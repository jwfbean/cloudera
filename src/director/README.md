# Cloudera Director tools

## Cloudera Director Config Files

**aws.simple.conf** specifies a 5 node cluster on the specified VPC
**dev.conf** specifies a 3 node cluster on the specified VPC (HDFS comes up red)

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
* Edit the create-cluster.sh script(s) to specify your AWS access credentials
* Edit the aws.simple.conf and/or dev.conf files to specify your subnet and 
security groups

## Every time you launch a cluster
* Spawn a launcher
* Place the aws hostname of the launcher in a file called launcher
* Run ./prepnlaunch.sh

## AMIs used in us-east
* **ami-c318a8a8** - Cloudera Director CSC (Client, Server, Config) a Cloudera Director Launcher preinstalled
* **ami-8767d1ec** - CDH5.4 Node preconfigured Centos node with CDH5.4 parcel preinstalled 
* **ami-a3daa0c6** - AD Server preconfigured with cm user for kerberization (Admin and CM password Passw0rd!)
