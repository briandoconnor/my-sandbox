use strict;
use JSON;
use Data::Dumper;

my $d = {};

while(<STDIN>) {
  chomp;
  my $type = "";
  if ($_ =~ /tcga_pancancer/) {
    $type = "tcga";
  } elsif ($_ =~ /icgc_pancancer/) {
    $type = "icgc";
  } else {
    $type = "unknown";
  }
  $d->{types}{$type}++;
  my $donor = decode_json($_);
  $d->{total_donors}++;
  $d->{"$type\_donors"}++;
  if (defined($donor->{gnos_repos_with_complete_alignment_set})) {
    $d->{donors_with_gnos_complete}++;
    $d->{"$type\_donors_with_gnos_complete"}++;
    if (scalar(@{$donor->{gnos_repos_with_complete_alignment_set}})) {
      $d->{donors_with_gnos_complete_not_empty}++;
      $d->{"$type\_donors_with_gnos_complete_not_empty"}++;
      foreach my $gnos (@{$donor->{gnos_repos_with_complete_alignment_set}}) {
        $d->{counts}{$gnos}{$type}++;
      }
    }
  }
}

# print
#print "Total Donors: $total_donors\n";
#print "Donors with GNOS complete: $donors_with_gnos_complete\n";
#print "Donors with GNOS complete not empty: $donors_with_gnos_complete_not_empty\n";
#print "Counts:\n";
print Dumper($d);
