use strict;

# first sleep randomly 10-120 seconds
sleep (int(rand(111)) + 10);

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
# randomly select one for download
my $max = scalar(@d);
my $index = int(rand($max));
my $sample = $d[$index];
my @tokens = split /\|/, $sample;
my $oid = $tokens[0];
my $size = $tokens[1];

# create touch file and upload
print "$oid | $size\n";

# do download

# update touch file and upload
