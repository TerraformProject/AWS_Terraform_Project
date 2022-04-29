#!/bin/bash

# Installs nfs-utils and cachefilesd for EFS
yum install -y nfs-utils   # to ensure that NFS is installed on your Amazon Linux instance.
yum install cachefilesd
service cachefilesd start
chkconfig cachefilesd on    #autostart cachefilesd

# Create the EFS dir on host and mount the EFS Volum to it
mkdir /etc/ecs/efsVols
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,fsc "${WORDPRESS_EFS_ENDPOINT}":/ /etc/ecs/efsVols
service cachefilesd restart  #to ensure that our cachefiles service becomes aware of our newly mounted efs volume

# Ensure that cachefilesd auto starts upon host startup
vim /etc/fstab
"${WORDPRESS_EFS_ENDPOINT}":/ /efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,fsc,_netdev 0 0
