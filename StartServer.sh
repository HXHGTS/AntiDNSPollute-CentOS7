#!/bin/sh

echo "正在搭建无污染DNS. . . . . ."

yum install -y dnsmasq

echo "listen-address=0.0.0.0,127.0.0.1"> /etc/dnsmasq.conf

echo "server=208.67.222.222#5353">> /etc/dnsmasq.conf

iptables -t nat -I PREROUTING -p tcp --dport 5353 -j REDIRECT --to-ports 53

iptables -t nat -I PREROUTING -p udp --dport 5353 -j REDIRECT --to-ports 53

systemctl enable dnsmasq

systemctl start dnsmasq

echo "nameserver 127.0.0.1">> /etc/resolv.conf.conf

echo "无污染DNS搭建完成!"

echo "对外开放端口默认53与5353"

exit

