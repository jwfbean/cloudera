# Cloudera Director tools

## Cloudera Director Config Files

**aws.simple.conf** specifies a 5 node cluster on the specified VPC using m3.xlarge instances

**dev.conf** specifies a 3 node cluster on the specified VPC (HDFS comes up red due to underreplicated blocks) using m3.xlarge instances

## Helper scripts

**create-dev-cluster.sh** launches the cluster specified by
dev.conf from the launcher

**create-cluster.sh** launches the cluster specified by aws.simple.conf
from the launcher

## Scripts to invoke
**prepnlaunch-dev.sh** launches a 3 node cluster

**prepnlaunch.sh** launches a 5 node cluster

# Instructions for use

## One time only
* Create a subnet and VPC in EC2
* Edit the create-cluster.sh script(s) to specify your AWS access credentials (grep for CHANGE-ME)
* Edit the aws.simple.conf and/or dev.conf files to specify your subnet and 
security groups (grep for CHANGE-ME) as well as the proper CDH AMI (currently set to the CDH5.4 node AMI in us-east referred to below).
* place your pem file in the same directory as the prepnlaunch.sh script, name it hadoopsecurity.pem or edit the script

## Every time you launch a cluster
* Spawn a launcher using ami-c318a8a8
* Place the aws hostname of the launcher in a file called launcher
* Run ./prepnlaunch.sh

## AMIs used in us-east
* **ami-c318a8a8** - Cloudera Director CSC (Client, Server, Config) a Cloudera Director Launcher preinstalled
* **ami-8767d1ec** - CDH5.4 Node preconfigured Centos node with CDH5.4 parcel preinstalled 
* **ami-a3daa0c6** - AD Server preconfigured with cm user for kerberization (Admin and CM password Passw0rd!)

## AMIs created in eu-west
* **ami-2957655e** - Cloudera Director CSC (Client, Server, Config) a Cloudera Director Launcher preinstalled
* **ami-23576554** - CDH5.4 Node preconfigured Centos node with CDH5.4 parcel preinstalled 
* **ami-2d57655a** - AD Server preconfigured with cm user for kerberization (Admin and CM password Passw0rd!)
