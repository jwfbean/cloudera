export PEM=$1

export USER=ec2-user
export CM_URL=http://archive-primary.cloudera.com/cm5/installer/latest/cloudera-manager-installer.bin
export MASTER=`head -1 ./cluster`

echo $MASTER

disable_selinux () {
  scp -i $PEM ./selinux.conf $USER@$HOST:~/
  ssh -t -i $PEM $USER@$HOST sudo cp /home/$USER/selinux.conf /etc/sysconfig/selinux
}

enable_ntpd() {
  ssh -t -i $PEM $USER@$HOST sudo chkconfig ntpd on
}

disable_iptables() {
  ssh -t -i $PEM $USER@$HOST sudo chkconfig iptables off
}

get_installer() {
  ssh -t -i $PEM $USER@$MASTER 'rm cloudera-manager-installer.bin'
  ssh -t -i $PEM $USER@$MASTER wget $CM_URL
  ssh -t -i $PEM $USER@$MASTER chmod +x cloudera-manager-installer.bin
}

run_installer() {
  ssh -t -i $PEM $USER@$MASTER sudo /home/$USER/cloudera-manager-installer.bin
}

mount_storage() {
  ssh -t -i $PEM $USER@$HOST sudo mkdir /data01 /data02
  scp -i $PEM dofstab.sh $USER@$HOST:/home/$USER
  ssh -t -i $PEM $USER@$HOST "chmod +x /home/$USER/dofstab.sh"
  ssh -t -i $PEM $USER@$HOST sudo /home/$USER/dofstab.sh 
  ssh -t -i $PEM $USER@$HOST sudo mount -t ext4 /dev/xvdf /data01 
  ssh -t -i $PEM $USER@$HOST sudo mount -t ext4 /dev/xvdg /data02 
}

reboot_host () {
  echo rebooting $HOST
  ssh -t -i $PEM $USER@$HOST sudo reboot 
}

echo_local_hostname() {
  echo local hostname:
  ssh -t -i $PEM $USER@$HOST hostname
}

move_var_lib() {
  ssh -t -i $PEM $USER@$HOST sudo mkdir -p /data01/var/lib
  ssh -t -i $PEM $USER@$HOST sudo chmod 777 /data01/var/lib
  ssh -t -i $PEM $USER@$HOST sudo cp -R /var/lib /data01/var
  ssh -t -i $PEM $USER@$HOST sudo mv /var/lib /var/lib.old
  ssh -t -i $PEM $USER@$HOST sudo ln -s /data01/var/lib /var/lib
}

move_var_log() {
  ssh -t -i $PEM $USER@$HOST sudo mkdir -p /data01/var/log
  ssh -t -i $PEM $USER@$HOST sudo chmod 777 /data01/var/log
  ssh -t -i $PEM $USER@$HOST sudo mv /var/log /var/log.old
  ssh -t -i $PEM $USER@$HOST sudo ln -s /data01/var/log /var/log
}

move_opt_cloudera() {
  ssh -t -i $PEM $USER@$HOST sudo mkdir -p /data02/opt/cloudera
  ssh -t -i $PEM $USER@$HOST sudo chmod 777 /data02/opt/cloudera
  ssh -t -i $PEM $USER@$HOST sudo ln -s /data02/opt/cloudera /opt/cloudera
}



get_installer

for HOST in `cat ./cluster`; do
  echo $HOST
  echo_local_hostname
  disable_selinux
  enable_ntpd
  disable_iptables
  mount_storage
  move_var_log
  move_opt_cloudera
  move_var_lib
  reboot_host
done

#sleep 180

#run_installer
