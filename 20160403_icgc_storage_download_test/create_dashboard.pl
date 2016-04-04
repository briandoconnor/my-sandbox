use strict;

# inputs
my ($num) = @ARGV;

# vars
my $template = `cat dashboard.template`;
my $instances = "";
my $token = `cat token.txt`;
chomp $token;

# get the list of instance IDs
my $instances_list = `aws ec2 describe-instances | grep -i InstanceId`;
my $first = 1;
foreach my $line (split /\n/, $instances_list) {
  $line =~ /"InstanceId": "(\S+)"/;
  if ($first > 1 ) { $instances .= ","; }
  $instances .= qq|
                     {
                        "alias" : "Worker$first",
                        "period" : "60",
                        "region" : "us-east-1",
                        "metricName" : "NetworkIn",
                        "refId" : "A",
                        "namespace" : "AWS/EC2",
                        "statistics" : [
                           "Average"
                        ],
                        "dimensions" : {
                           "InstanceId" : "$1"
                        }
                     }
|;
  $first++;
}

$template =~ s/\@INSTANCES\@/$instances/g;
$template =~ s/\@NUMBER\@/$num/g;

open OUT, ">dashboard.temp.json" or die;
print OUT $template;
close OUT;

system qq|curl -H "Authorization: Bearer $token" -H "Accept: application/json" -H "Content-Type: application/json" -X POST http://localhost:3000/api/dashboards/db -d \@dashboard.temp.json|;

system ("rm dashboard.temp.json");
