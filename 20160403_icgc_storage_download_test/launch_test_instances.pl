use strict;
use Getopt::Long;
use MIME::Base64 qw( encode_base64 );

# vars
my ($rounds, $instances_per_round, $delay_min, $download_counts);
my $instance_id = "ami-2f383345";
my $key = "brian-ucsc-east-1";
my $sec_group = "sg-00a8ee78";
my $instance_type = "m1.xlarge";
my $spot_price = "0.06";

# options
GetOptions ("rounds=i" => \$rounds,
"instances=i" => \$instances_per_round,
"download-counts=i" => \$download_counts,
"delay-min=i" => \$delay_min);
if ($delay_min < 1) {$delay_min = 1;}
if ($rounds < 1) { $rounds = 1; }
if ($instances_per_round < 1) { $instances_per_round = 1; }
if ($download_counts < 1) { $download_counts = 1; }
if ($delay_min < 1) { $delay_min = 1; }

# main loop
for (my $i=0; $i<$rounds; $i++) {

  # user data
  # make the user data
  my $user_data_script =  qq|#!/bin/bash
perl /home/ubuntu/gitroot/my-sandbox/20160403_icgc_storage_download_test/run_download.pl $download_counts $instance_type
shutdown -h now
|;

  # create a spot request(s)
  # make instance JSON, see http://docs.aws.amazon.com/cli/latest/reference/ec2/request-spot-instances.html
  open OUT, ">specification.json" or die;
  print OUT qq|{
  "ImageId": "$instance_id",
  "UserData": "|.chomp(encode_base64($user_data_script)).qq|",
  "KeyName": "$key",
  "SecurityGroupIds": [ "$sec_group" ],
  "InstanceType": "$instance_type"
}|;
  close OUT;

  my $status = system(qq|aws ec2 request-spot-instances --spot-price "$spot_price" --instance-count $instances_per_round --type "one-time" --launch-specification file://specification.json |);

  # now sleep between rounds
  sleep($delay_min * 60);
}

# cleanup
system("rm specification.json");
