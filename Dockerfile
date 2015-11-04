FROM centos:centos7

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

RUN yum -y install cobbler tftp-server dhcp openssl

RUN apachectl ; cobblerd ; cobbler get-loaders ; pkill cobblerd ; pkill httpd

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
