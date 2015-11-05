# docker-cobbler  
这是一个运行在docker里的cobbler平台。
###启动前准备：  
**请先挂载系统镜像，不然容器内看不到系统镜像**：（挂载到/mnt下）  
  把iso文件放入/opt/iso 文件夹下，执行import-iso.sh可以自动挂载所有镜像 
  mount -t iso9660 -o loop,ro /opt/iso/centos.iso /mnt/centos  
  mount -t iso9660 -o loop,ro /opt/iso/ubuntu.iso /mnt/ubuntu 
### 安装说明
- 机器已经正确安装好docker
- 机器正确链接到互联网
- 目前在centos7下安装的doker测试通过，其他环境自行测试
###安装步骤：
**1.构建docker镜像**
使用git clone命令把本项目克隆下来，进入本项目所在目录执行以下命令构建docker环境
``` shell
$ sudo docker build -t docker/cobbler .
```
**2.启动docker容器**
启动dicker容器命令如下：  
``` shell
  docker run -d -e SERVER_IP=192.168.2.8 -e DHCP_RANGE="192.168.2.230 192.168.2.235" -e ROOT_PASSWORD=cobbler -e DHCP_SUBNET=192.168.2.0 -e DHCP_ROUTER=192.168.2.1 -e DHCP_DNS=223.5.5.5  --name cobbler --net host -v /mnt:/mnt:ro cobbler
```

变量说明：共有6个变量：  
  **SERVER_IP**:指定本机内网卡的IP地址  **必填**   
  **DHCP_RANGE**：指定批量装机需要获取的IP地址段  **必填**  
  **ROOT_PASSWORD**：指定批量装机后系统默认的root密码  **必填**  
  **DHCP_SUBNET**：指定DHCP的网段  **必填**  
  **DHCP_ROUTER**：指定DHCP的网管  **必填**  
  **DHCP_DNS**：指定DHCP的DNS地址  **必填**  

**3.进入已经启动的Doker容器**
``` shell
docker exec -it cobbler /bin/bash
```
就可以在镜像里面管理cobbler了
**或者**
在web页面也可以管理cobbler
访问以下地址：http://192.168.3.184/cobbler_web  注意替换成本机IP

在docker容器里导入镜像到cobbler安装菜单使用以下命令($ISO_NAME替换成镜像名称,路径替换成要导入镜像的具体路径)：
``` shell
 cobbler import  --path=/mnt/centos --name=$ISO_NAME
```
**4.cobbler中增加系统镜像**
4.1 重新挂载镜像到主机的/mnt目录下
4.2 重新启动docker容器，并进入doker容器
4.3 执行import命令   
``` shell
cobbler import  --path=/mnt --name=$ISO_NAME
```

**如启动后局域网所有不到cobbler服务请配置防火墙规则或者关闭防火墙**
可用ss -antup命令看到启动的端口
配置防火墙：  
  firewall-cmd --add-service=dhcp  
  firewall-cmd --add-service=http  
  firewall-cmd --add-service=tftp  
  firewall-cmd --add-port=25151/tcp  
cobbler配置命令请参考官方文档。
