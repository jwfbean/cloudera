scp -i $PEM dofstab.sh $USER@$HOST:/home/$USER
ssh -t -i $PEM $USER@$HOST "chmod +x /home/$USER/dofstab.sh"
ssh -t -i $PEM $USER@$HOST sudo /home/$USER/dofstab.sh
