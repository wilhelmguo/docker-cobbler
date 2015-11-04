# Dockerfile for Cobbler 
FROM centos:centos7
MAINTAINER  Tuan800 
COPY ./config /etc/selinux/config
RUN systemctl stop firewalld
RUN systemctl disable firewalld  
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum install cobbler cobbler-web dnsmasq syslinux pykickstart dhcp
RUN systemctl enable cobblerd
RUN systemctl start cobblerd
RUN systemctl enable httpd
RUN systemctl start httpd
COPY ./settings /etc/cobbler/settings
# IP_ETH1=$(ifconfig eth0 | grep 'inet addr:' | cut -d":" -f2 | cut -d" " -f1)
# RUN sed -i '/next_server:127.0.0.1/c\next_server:{IP_ETH1}' /etc/cobbler/settings
# RUN sed -i '/server:127.0.0.1/c\next_server:{IP_ETH1}' /etc/cobbler/settings
COPY ./modules.conf /etc/cobbler/modules.conf
RUN systemctl enable xinetd
RUN systemctl start xinetd
COPY ./rsync /etc/xinetd.d/rsync
COPY ./debmirror.conf etc/debmirror.conf
COPY ./start.sh /
CMD ["/bin/bash", "/start.sh"]