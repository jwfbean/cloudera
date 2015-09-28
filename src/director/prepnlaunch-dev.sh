scp -i ./hadoopsecurity.pem ./hadoopsecurity.pem ec2-user@`cat launcher-dev`:~/
ssh -i ./hadoopsecurity.pem ec2-user@`cat launcher-dev` 'chmod 600 ./hadoopsecurity.pem'
scp -i ./hadoopsecurity.pem ./create-dev-cluster.sh ec2-user@`cat launcher-dev`:~/
scp -i ./hadoopsecurity.pem ./dev.conf ec2-user@`cat launcher-dev`:~/
ssh -i ./hadoopsecurity.pem ec2-user@`cat launcher-dev` 'sh create-dev-cluster.sh'
