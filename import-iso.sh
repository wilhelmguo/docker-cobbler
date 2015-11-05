#!/bin/bash

mountpoint=/mnt

#Import isos to cobbler
for iso in `ls /opt/iso`; do
    ISO_NAME=${iso%.*}
    mkdir -p $ISO_NAME
	mount -t iso9660 -o loop,ro /opt/iso/$iso $mountpoint/$ISO_NAME
done
