#!/bin/sh

echo "正在搭建无污染DNS. . . . . ."

yum install -y dnsmasq curl iptables-services bind-utils

systemctl enable iptables && systemctl start iptables

echo "no-resolv"> /etc/dnsmasq.conf

ip=echo $(ip addr |grep inet|grep eth0|awk '{print $2}' |awk -F "/" '{print $1}') && echo listen-address=$ip >> /etc/dnsmasq.conf

echo listen-address=127.0.0.1 >> /etc/dnsmasq.conf

echo "port=53">> /etc/dnsmasq.conf

echo "server=208.67.222.222#5353">> /etc/dnsmasq.conf

echo "server=208.67.220.222#5353">> /etc/dnsmasq.conf

echo "server=208.67.222.220#5353">> /etc/dnsmasq.conf

echo "server=208.67.220.220#5353">> /etc/dnsmasq.conf

curl -s https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf|sed 's/119.29.29.29/182.254.116.116/g' >/etc/dnsmasq.d/accelerated-domains.china.conf

iptables -t nat -I PREROUTING -p tcp --dport 5353 -j REDIRECT --to-ports 53

iptables -t nat -I PREROUTING -p udp --dport 5353 -j REDIRECT --to-ports 53

systemctl enable dnsmasq && systemctl start dnsmasq

echo "nameserver 127.0.0.1"> /etc/resolv.conf

echo "无污染DNS搭建完成!"

echo "对外开放端口默认5353"

echo "正在验证DNS运行状态. . . . . ."

nslookup www.google.com 127.0.0.1

nslookup www.youtube.com 127.0.0.1

nslookup www.baidu.com 127.0.0.1

exit

