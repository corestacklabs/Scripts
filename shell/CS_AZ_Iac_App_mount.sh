#!/bin/bash

mkdir -p /opt/core/cache

(echo n; echo p; echo 1; echo 2048; echo;  echo w) | fdisk /dev/sdc)

mkfs -t ext4 /dev/sdc1

cmp_cache_uuid=$(blkid -s UUID -o value /dev/sdc1)

echo "UUID=$cmp_cache_uuid /opt/core/cache/ ext4    defaults,nofail 0 0" >> /etc/fstab
