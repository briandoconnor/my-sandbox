use strict;
use JSON;
use Data::Dumper;

my $d = {};

open BROAD, ">broad_variant_calling.tsv" or die;
open DKFZ, ">dkfs_embl_variant_calling.tsv" or die;
open SANGER, ">sanger_variant_calling.tsv" or die;

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

  # the alignments
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

  # the variant calls
  if (defined($donor->{variant_calling_results})) {
    $d->{"$type\_donors_with_variant_calling_results"}++;
    if (scalar(keys %{$donor->{variant_calling_results}}) == 3) {
      $d->{"$type\_donors_with_complete_variant_calling_results"}++;
    }
    foreach my $var_call_type (keys %{$donor->{variant_calling_results}}) {
      foreach my $var_gnos_loc (@{$donor->{variant_calling_results}{$var_call_type}{gnos_repo}}) {
        $d->{var_counts}{$var_gnos_loc}{$type}{$var_call_type}++;
      }
    }
    # print out those not defined!
    if (!defined($donor->{variant_calling_results}{sanger_variant_calling}) || scalar (@{$donor->{variant_calling_results}{sanger_variant_calling}{gnos_repo}}) < 1) {
      print SANGER $donor->{donor_unique_id}."\n";
    }
    if (!defined($donor->{variant_calling_results}{dkfz_embl_variant_calling})  || scalar (@{$donor->{variant_calling_results}{dkfz_embl_variant_calling}{gnos_repo}}) < 1) {
      print DKFZ $donor->{donor_unique_id}."\n";
    }
    if (!defined($donor->{variant_calling_results}{broad_variant_calling}) || scalar (@{$donor->{variant_calling_results}{broad_variant_calling}{gnos_repo}}) < 1) {
      print BROAD $donor->{donor_unique_id}."\n";
    }
  }
}

# print
#print "Total Donors: $total_donors\n";
#print "Donors with GNOS complete: $donors_with_gnos_complete\n";
#print "Donors with GNOS complete not empty: $donors_with_gnos_complete_not_empty\n";
#print "Counts:\n";
print Dumper($d);

close BROAD;
close DKFZ;
close SANGER;
