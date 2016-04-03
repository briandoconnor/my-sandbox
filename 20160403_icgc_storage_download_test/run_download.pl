use strict;

my ($repeats, $instance_type) = @ARGV;

if ($instance_type eq '') {
  $instance_type = "unknown";
}

# next setup directory
system ("mkdir -p /mnt/data");

# read the manifest file and push into array
my @d = ();
open IN, "</home/ubuntu/icgc-storage-client-1.0.13/manifest.txt" or die;
while (<IN>) {
  my @a = split /\t/;
  if (!/^repo_code/) {
    push @d, "$a[2]|$a[5]";
  }
}
close IN;

my $curr = $repeats;
if ($curr <= 0) { $curr = 1; $repeats = 1; }
while($curr > 0) {

  # loop
  $curr--;

  # clean
  system ("rm -rf /mnt/data/*");

  # first sleep randomly 10-120 seconds
  sleep (int(rand(111)) + 10);

  # randomly select one for download
  my $max = scalar(@d);
  my $index = int(rand($max));
  my $sample = $d[$index];
  my @tokens = split /\|/, $sample;
  my $oid = $tokens[0];
  my $size = $tokens[1];

  # create touch file and upload
  my $start_time = `date +\%s`;
  chomp $start_time;
  open OUT, ">/home/ubuntu/$oid.tsv" or die;
  print OUT "OID\t$oid\nINSTANCE\t$instance_type\nSIZE\t$size\nSTART\t$start_time\n";
  close OUT;

  # upload to s3
  system ("aws s3 cp /home/ubuntu/$oid.tsv s3://oconnor-test-bucket/icgc-storage-download-testing/$oid.$repeats.$instance_type.running.tsv");

  # do download
  my $status = system("/home/ubuntu/icgc-storage-client-1.0.13/bin/icgc-storage-client download --object-id $oid --output-dir /mnt/data/");

  # update touch file and upload
  my $end_time = `date +\%s`;
  chomp $end_time;
  open OUT, ">>/home/ubuntu/$oid.tsv" or die;
  print OUT "END\t$end_time\nEXITCODE\t$status";
  close OUT;

  # upload to s3
  system ("aws s3 rm s3://oconnor-test-bucket/icgc-storage-download-testing/$oid.$repeats.$instance_type.running.tsv");
  system ("aws s3 cp /home/ubuntu/$oid.tsv s3://oconnor-test-bucket/icgc-storage-download-testing/$oid.$repeats.$instance_type.finished.tsv");

}
