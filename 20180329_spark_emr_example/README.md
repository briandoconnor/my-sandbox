# README

These directions assume you have Maven and Java 8 installed.
I'm working on a mac so YMMV.

```
# Create your conda python environment:
conda create -n python_3_6_5_aws_cli python=3.6.5 anaconda

# use it
source activate python_3_6_5_aws_cli

# install the AWS CLI, make sure you setup you config in ~/.aws/credentials
pip install awscli --upgrade --user

# compile the code 
git commit -a -m updates; git push && mvn clean install && aws s3 cp target/simple-project-1.0.jar s3://briandoconnor-toil-testing/
```
