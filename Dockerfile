FROM centos:centos7

RUN rpm -ivh http://mirrors.aliyun.com/centos/7.1.1503/os/x86_64/Packages/wget-1.14-10.el7_0.1.x86_64.rpm && \
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && \
wget -O /etc/yum.repos.d/cobbler26.repo http://download.opensuse.org/repositories/home:/libertas-ict:/cobbler26/CentOS_CentOS-7/home:libertas-ict:cobbler26.repo

RUN rpm -Uvh ftp://rpmfind.net/linux/epel/6/x86_64/debmirror-2.14-2.el6.noarch.rpm  --nodeps --force

RUN yum -y install cobbler tftp-server dhcp openssl pykickstart fence-agents cobbler-web

RUN apachectl ; cobblerd ; cobbler get-loaders ; pkill cobblerd ; pkill httpd

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
