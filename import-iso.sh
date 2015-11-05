#!/bin/bash


#Import isos to cobbler
for iso in `ls /opt/iso`; do
    ISO_NAME=${iso%.*}
    mkdir -p /mnt/$ISO_NAME
	mount -t iso9660 -o loop,ro /opt/iso/$iso /mnt/$ISO_NAME
done
