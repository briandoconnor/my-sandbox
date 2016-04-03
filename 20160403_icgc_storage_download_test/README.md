##About

This is a script that is designed to run on spot instances to perform downloads
from the ICGC storage system. It's designed to run on a spot instance and
repeat a random download for n times.  The bandwidth used can be monitored via
CloudWatch and this script will write a summary back to S3 for interpretation
later.

The companion script sets up a dashboard in Grafana and automatically adds all
running instances.

### launch_test_instances.pl

This creates multiple rounds of spot instance launches so it gradually ramps up the
fleet of images running the download test.  It also periodically calls the `create_dashboard.pl`
script to update the locally running Grafana instance.

### run_download.pl

This runs on each test host and performs one or more download tests, writing metadata back to S3.

### create_dashboard.pl

This is called by launch_test_instances.pl after a VM is launched.  It's job is to setup
the instances in Grafana.

##Strategy

0. make a Grafana host and generate an API key, checkout this repo, install AWS CLI and configure it
0. make a base AMI with these scripts, the AWS CLI
0. on the Grafana host

##References

* http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/ApiReference-cmd-ModifyInstanceAttribute.html
* http://docs.aws.amazon.com/cli/latest/reference/ec2/modify-instance-attribute.html
* http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
* http://docs.aws.amazon.com/cli/latest/userguide/cli-ec2-launch.html
* http://stackoverflow.com/questions/10541363/self-terminating-aws-ec2-instance
