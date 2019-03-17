#!/bin/bash
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o wlp1s0 -j MASQUERADE
iptables -A FORWARD -i wlx086a0a975551 -o wlp1s0 -j ACCEPT
iptables -A FORWARD -i wlp1s0 -o wlx086a0a975551 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp -m udp -i wlx086a0a975551 --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp -m udp --sport 53 -j ACCEPT
systemctl start dnsmasq
