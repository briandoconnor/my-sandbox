# SPARK Example

This is a simple application to find k-mers from fastq files hosted in the
[HCA Preview](https://preview.data.humancellatlas.org/) ["Blue Box"](https://github.com/HumanCellAtlas/data-store) aka
the cloud-based data storage system used by the project.  It is meant to
provide a concrete example of processing HCA data on the cloud using SPARK.

The idea is this application can run in SPARK and scale out the generation
of k-mers and their aggregation/counting in a way that takes advantage of the
parallelization of a SPARK cluster.  Here I use EMR on AWS to setup a SPARK
cluster and control the fastq files I process using a simple manifest file.

You can use this code as a starting point for your own exploration of the HCA
data.  Fork it and have fun!

A future iteration of this code could do something more interesting.  I'm
thinking of implementing what Titus Brown covers in this [blog post](http://ivory.idyll.org/blog/2016-sourmash.html).  
Specifically it would be super cool to calculate MinHash signature for each
of the biomaterials in HCA and use these to quickly compare samples by samples.
Perhaps this would be useful in building a feature to ask "what cells are
most similar to this cell" using scRNAseq data for example.

## More Information

# Running the Example

## Launch an EMR Cluster



## Setup Inputs/Outputs

```

```

## Dependencies

These directions assume you have Maven and Java 8 installed.
I'm working on a mac so YMMV.

```
# Create your conda python environment:
conda create -n python_3_6_5_aws_cli python=3.6.5 anaconda

# use it
source activate python_3_6_5_aws_cli

# install the AWS CLI, make sure you setup you config in ~/.aws/credentials
pip install awscli --upgrade
```

## Compile

```
# compile the code
git commit -a -m updates; git push && mvn clean install && aws s3 cp target/simple-project-1.0.jar s3://briandoconnor-toil-testing/

# now run it via the console
```

## Running


# Sample Output

```
03e63ba5-1818-42e4-a078-95d83104eb27	6	CAGAGTACTTTTTTTTTTTTTTTTTTTTTTTT
03e63ba5-1818-42e4-a078-95d83104eb27	4	CGCAGAGTACTTTTTTTTTTTTTTTTTTTTTT
03e63ba5-1818-42e4-a078-95d83104eb27	3	TAGGCACACGCTGAGCCAGTCAGTGTAGCGCG
03e63ba5-1818-42e4-a078-95d83104eb27	2	ATCAGTAGGGTAAAACTAACCTGTCTCACGAC
03e63ba5-1818-42e4-a078-95d83104eb27	1	ATTGTCAACAACGTCTGTGCAGGGCTAGTTGG
3df2bbe9-5530-4236-bb7c-be058749f179	44	CTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
3df2bbe9-5530-4236-bb7c-be058749f179	43	GTACTTTTTTTTTTTTTTTTTTTTTTTTTTTT
3df2bbe9-5530-4236-bb7c-be058749f179	36	GAGTACTTTTTTTTTTTTTTTTTTTTTTTTTT
3df2bbe9-5530-4236-bb7c-be058749f179	34	CGCAGAGTACTTTTTTTTTTTTTTTTTTTTTT
3df2bbe9-5530-4236-bb7c-be058749f179	33	CAGAGTACTTTTTTTTTTTTTTTTTTTTTTTT
3df2bbe9-5530-4236-bb7c-be058749f179	14	TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTC
3df2bbe9-5530-4236-bb7c-be058749f179	13	TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTA
3df2bbe9-5530-4236-bb7c-be058749f179	12	GCCAGTAGCATATGCTTGTCTCAAAGATTAAG
3df2bbe9-5530-4236-bb7c-be058749f179	11	AGCATATGCTTGTCTCAAAGATTAAGCCATGC
3df2bbe9-5530-4236-bb7c-be058749f179	10	GATCCTGCCAGTAGCATATGCTTGTCTCAAAG
eace1ea5-d04d-4066-a069-09a50b4563fc	3	GATCCCCATCACGAATGGGGTTCAACGGGTTA
eace1ea5-d04d-4066-a069-09a50b4563fc	2	GGCGCACAGAGGCCACACTGAGGACATCATCA
eace1ea5-d04d-4066-a069-09a50b4563fc	1	AGGAGCGATCGGGCTGATGTTCCTGATGCTTG
d03e1fb5-0bd6-41ad-9744-c87af0fbdc33	114	GTACTTTTTTTTTTTTTTTTTTTTTTTTTTTT
d03e1fb5-0bd6-41ad-9744-c87af0fbdc33	104	CTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
d03e1fb5-0bd6-41ad-9744-c87af0fbdc33	103	GAGTACTTTTTTTTTTTTTTTTTTTTTTTTTT
d03e1fb5-0bd6-41ad-9744-c87af0fbdc33	93	CAGAGTACTTTTTTTTTTTTTTTTTTTTTTTT
d03e1fb5-0bd6-41ad-9744-c87af0fbdc33	90	CGCAGAGTACTTTTTTTTTTTTTTTTTTTTTT
d03e1fb5-0bd6-41ad-9744-c87af0fbdc33	80	AACGCAGAGTACTTTTTTTTTTTTTTTTTTTT
d03e1fb5-0bd6-41ad-9744-c87af0fbdc33	76	ATCAACGCAGAGTACTTTTTTTTTTTTTTTTT
d03e1fb5-0bd6-41ad-9744-c87af0fbdc33	75	TATCAACGCAGAGTACTTTTTTTTTTTTTTTT
d03e1fb5-0bd6-41ad-9744-c87af0fbdc33	64	TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTC
d03e1fb5-0bd6-41ad-9744-c87af0fbdc33	40	TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTCT
0d89a3df-c13e-4817-9bda-91205f4b5d53	27	TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
0d89a3df-c13e-4817-9bda-91205f4b5d53	12	TAGCCTTGGAGGATGGTCCCCCCATATTCAGA
```
