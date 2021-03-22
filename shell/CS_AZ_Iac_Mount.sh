#!/bin/bash

mkdir -p /var/lib/mongo/
mkdir -p /var/log/mongo/
mkdir -p /var/lib/mysql
mkdir -p /opt/core/cache

(echo n; echo p; echo 1; echo 2048; echo;  echo w) | fdisk /dev/sdc
(echo n; echo p; echo 1; echo 2048; echo;  echo w) | fdisk /dev/sdd
(echo n; echo p; echo 1; echo 2048; echo;  echo w) | fdisk /dev/sde
(echo n; echo p; echo 1; echo 2048; echo;  echo w) | fdisk /dev/sdf

mkfs -t ext4 /dev/sdc1
mkfs -t ext4 /dev/sdd1
mkfs -t ext4 /dev/sde1
mkfs -t ext4  /dev/sdf1

mount /dev/sdc1/ /var/lib/mongo
mount /dev/sdd1 /var/log/mongo
mount /dev/sde1 /var/lib/mysql
mount  /dev/sdf1 /opt/core/cache

mongo_data_uuid=$(blkid -s UUID -o value /dev/sdc1)
echo "UUID=$mongo_data_uuid /var/lib/mongo/ ext4    defaults,nofail 0 0" >> /etc/fstab

mongo_log_uuid=$(blkid -s UUID -o value /dev/sdd1)
echo "UUID=$mongo_log_uuid /var/log/mongo/ ext4    defaults,nofail 0 0" >> /etc/fstab

mysql_data_uuid=$(blkid -s UUID -o value /dev/sde1)
echo "UUID=$mysql_data_uuid /var/lib/mysql/ ext4    defaults,nofail 0 0" >> /etc/fstab

cmp_cache_uuid=$(blkid -s UUID -o value /dev/sdf1)
echo "UUID=$cmp_cache_uuid /opt/core/cache/ ext4    defaults,nofail 0 0" >> /etc/fstab
