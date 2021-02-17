#!/bin/sh

echo "正在搭建无污染DNS. . . . . ."

yum install -y dnsmasq bind-utils

systemctl enable iptables && systemctl start iptables

echo "addn-hosts=/etc/dnsmasq.hosts" > /etc/dnsmasq.conf

echo "resolv-file=/etc/resolv.dnsmasq.conf" >> /etc/dnsmasq.conf

echo "conf-dir=/etc/dnsmasq.d" >> /etc/dnsmasq.conf

echo "server=208.67.222.222#5353" >> /etc/dnsmasq.conf

echo "server=208.67.220.222#5353" >> /etc/dnsmasq.conf

echo "server=208.67.222.220#5353" >> /etc/dnsmasq.conf

echo "server=208.67.220.220#5353" >> /etc/dnsmasq.conf

echo "port=9953">> /etc/dnsmasq.conf

echo "nameserver 100.100.2.136"> /etc/resolv.dnsmasq.conf

echo "nameserver 100.100.2.138">> /etc/resolv.dnsmasq.conf

mkdir /etc/dnsmasq.d

curl -s https://cdn.jsdelivr.net/gh/felixonmars/dnsmasq-china-list/accelerated-domains.china.conf|sed 's/114.114.114.114/100.100.2.136/g' >/etc/dnsmasq.d/accelerated-domains.china.conf

systemctl enable dnsmasq && systemctl start dnsmasq

echo "无污染DNS搭建完成!"

echo "对外开放端口默认9953"

exit 0

