use strict;
use JSON;
use Data::Dumper;

if (!-e "donor_p_150526020206.jsonl.gz") { system("wget http://pancancer.info/gnos_metadata/2015-05-26_02-02-06_UTC/donor_p_150526020206.jsonl.gz"); }

my $donors = {};

# first, harvest the donor IDs of what we need to look at
foreach my $dir (glob ("data/*")) {
  #print "$dir\n";
  if (-d "$dir") {
    $dir =~ /data\/(\S+)/;
    #print "DIR: $dir\n";
    $donors->{$1} = 1;
  } else { print "NOT DIR: $dir\n"; }
}

# fixes, a data structure to contain the mapped information to fix the original files

open IN, "gunzip -c donor_p_150526020206.jsonl.gz | " or die "Can't open donor_p_150526020206.jsonl.gz";

while (<IN>) {
  foreach my $key (keys %{$donors}) {
    #print "KEY: $key\n";
    if (/$key/) {
      delete $donors->{$key};
      my $jd = decode_json ($_);
      print Dumper $jd;
      die;

      # for the aligned normal

      # for the aligned tumor

    }
  }
}

close IN;

# now that I've collected all the mapping info I need, open up the original files
# and edit them to correct the mapping issue.
