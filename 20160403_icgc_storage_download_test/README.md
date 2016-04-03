!About

This is a script that is designed to run on spot instances to perform downloads
from the ICGC storage system. It's designed to run on a spot instance and
repeat a random download for n times.  The bandwidth used can be monitored via
CloudWatch and this script will write a summary back to S3 for interpretation
later.

The companion script sets up a dashboard in Grafana and automatically adds all
running instances.

!!Strategy



!!References

* http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/ApiReference-cmd-ModifyInstanceAttribute.html
* http://docs.aws.amazon.com/cli/latest/reference/ec2/modify-instance-attribute.html
* http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
* http://docs.aws.amazon.com/cli/latest/userguide/cli-ec2-launch.html
* http://stackoverflow.com/questions/10541363/self-terminating-aws-ec2-instance
