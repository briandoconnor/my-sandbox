use strict;

my $info = {};

my @broad = ('broad-brian/a76d7d7a-6f19-4ae9-a152-7b909130946c/35a74e53-16ff-4764-8397-6a9b02dfe733.broad-mutect.20151216.somatic.snv_mnv.vcf.gz', 'broad-brian/a76d7d7a-6f19-4ae9-a152-7b909130946c/35a74e53-16ff-4764-8397-6a9b02dfe733.broad-snowman.20151216.somatic.indel.vcf.gz', 'broad-brian/a76d7d7a-6f19-4ae9-a152-7b909130946c/35a74e53-16ff-4764-8397-6a9b02dfe733.broad-dRanger_snowman.20151216.somatic.sv.vcf.gz');
my @sanger = ('sanger-brian/0bac6371-e554-44b6-acb1-64e452db583f/35a74e53-16ff-4764-8397-6a9b02dfe733.svcp_1-0-5.20150707.somatic.snv_mnv.vcf.gz', 'sanger-brian/0bac6371-e554-44b6-acb1-64e452db583f/35a74e53-16ff-4764-8397-6a9b02dfe733.svcp_1-0-5.20150707.somatic.indel.vcf.gz', 'sanger-brian/0bac6371-e554-44b6-acb1-64e452db583f/35a74e53-16ff-4764-8397-6a9b02dfe733.svcp_1-0-5.20150707.somatic.sv.vcf.gz');
my @dkfz = ('dkfz-brian/f72d245f-9340-4adf-8863-4ede9a7afbe4/35a74e53-16ff-4764-8397-6a9b02dfe733.dkfz-snvCalling_1-0-132-1.20150731.somatic.snv_mnv.vcf.gz', 'dkfz-brian/f72d245f-9340-4adf-8863-4ede9a7afbe4/35a74e53-16ff-4764-8397-6a9b02dfe733.dkfz-indelCalling_1-0-132-1.20150731.somatic.indel.vcf.gz', 'dkfz-brian/f72d245f-9340-4adf-8863-4ede9a7afbe4/35a74e53-16ff-4764-8397-6a9b02dfe733.embl-delly_1-3-0-preFilter.20150731.somatic.sv.vcf.gz');

process("broad", @broad);
process("sanger", @sanger);
process("dkfz", @dkfz);

sub process {

  my $workflow = shift;
  my @files = @_;
  
  $info = {};
  my $info_str = "";
  foreach my $i (@files) {
    print "processing file info $i\n";
    parse_info($i, $info);
    foreach my $info_key (keys %{$info}) {
      $info_str .= "##INFO=".$info_key."\n";
    }
  }
  my $header = <<"EOS";
##fileformat=VCFv4.1
##variant_merge=$workflow
$info_str##FORMAT=<ID=alt_count,Number=.,Type=String,Description="Unknown">
##FORMAT=<ID=ref_count,Number=.,Type=String,Description="Unknown">
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  normal-tumor
EOS

  open my $OUT, ">$workflow.vcf" or die;

  print $OUT $header;

  foreach my $i (@files) {
    print "processing file $i\n";
    process_file($i, $OUT);
  }
  close $OUT;

  sort_and_index($workflow);

}

sub sort_and_index {

  my ($file) = @_;

  my $cmd = "sudo docker run --rm \\
        -v `pwd`/$file.vcf:/input.vcf:rw \\
        -v /datastore/refdata/public:/ref \\
        -v ~/vcflib/:/home/ngseasy/vcflib/ \\
        -v `pwd`:/outdir/:rw \\
        compbio/ngseasy-base:a1.0-002 /bin/bash -c \\
        \"vcf-sort /input.vcf > /outdir/$file.sorted.vcf; \\
        echo indexing; \\
        bgzip -f /outdir/$file.sorted.vcf ; \\
        tabix -p vcf /outdir/$file.sorted.vcf.gz\"
   ";

  print "$cmd\n";

  my $result = system($cmd);

  print "Status of sort: $result\n";
}


sub parse_info {
  my ($file, $info_hash) = @_;
  open(IN, "zcat $file |") or die;
  while(<IN>) {
    chomp;
    if (/^##INFO=(.+)$/) {
      $info_hash->{$1} = 1;
    }
  }
  close IN;
}

sub process_file {
  my ($file, $OUT) = @_;
  open(IN, "zcat $file |") or die;
  while(<IN>) {
    chomp;
    next if (/^#/);
    next if (!/PASS/);
    my @a = split /\t/;
    # FIXME: not sure if this is sufficient
    if (scalar(@a) == 9) {
      print $OUT "$a[0]\t$a[1]\t$a[2]\t$a[3]\t$a[4]\t$a[5]\t$a[6]\t$a[7]\t$a[8]\t$a[9]\n"; 
    } else {
      print $OUT "$a[0]\t$a[1]\t$a[2]\t$a[3]\t$a[4]\t$a[5]\t$a[6]\t$a[7]\tGT:alt_count:ref_count\t./.:.:.\n";
    }
  }
  close IN;
}
