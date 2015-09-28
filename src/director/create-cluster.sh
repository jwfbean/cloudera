export AWS_ACCESS_KEY_ID=CHANGE-ME
export AWS_SECRET_ACCESS_KEY=CHANGE-ME

cloudera-director bootstrap-remote ./aws.simple.conf --lp.remote.username=admin --lp.remote.password=admin --lp.remote.hostAndPort=localhost:7189
