grep xvdf /etc/fstab || echo '/dev/xvdf    /data01    ext4    defaults    0 0' >> /etc/fstab
grep xvdg /etc/fstab || echo '/dev/xvdg    /data02   ext4    defaults    0 0' >> /etc/fstab
