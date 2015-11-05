#!/bin/bash

mountpoint=/mnt

#Import isos to cobbler
for iso in `ls /opt/iso`; do
	mount -t iso9660 -o loop,ro /mnt/opt/$iso $mountpoint
done