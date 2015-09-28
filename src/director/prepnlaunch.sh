scp -i ./hadoopsecurity.pem ./hadoopsecurity.pem ec2-user@`cat launcher`:~/
ssh -i ./hadoopsecurity.pem ec2-user@`cat launcher` 'chmod 600 ./hadoopsecurity.pem'
scp -i ./hadoopsecurity.pem ./create-cluster.sh ec2-user@`cat launcher`:~/
scp -i ./hadoopsecurity.pem ./aws.simple.conf ec2-user@`cat launcher`:~/
ssh -i ./hadoopsecurity.pem ec2-user@`cat launcher` 'sh create-cluster.sh'
