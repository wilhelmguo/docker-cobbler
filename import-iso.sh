#!/bin/bash

mountpoint=/mnt

#Import isos to cobbler
for iso in `ls /opt/iso`; do
        ISO_NAME=$($iso | cut -d"." -f1)
	mount -t iso9660 -o loop,ro /opt/iso/$iso $mountpoint/$ISO_NAME
done
