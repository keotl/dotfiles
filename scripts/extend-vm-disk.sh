#!/bin/sh
DISK=$1

fdisk "${DISK}" <<EOF
n
p
1


t
3
8e
p
w
EOF

pvcreate "${DISK}1"
vgextend ubuntu-template-vg "${DISK}1"
lvextend -l +100%FREE /dev/ubuntu-template-vg/root
resize2fs /dev/ubuntu-template-vg/root
df -h
