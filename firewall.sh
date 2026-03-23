#!/bin/bash
iptables -F
iptables -X
iptables -Z
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --sport 53 -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --sports 80,443 -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -p tcp -m multiport --sports 80,443 -j ACCEPT
iptables -A INPUT -s 10.0.2.5 -p tcp -m multiport --dports 80,443 -j DROP
iptables -A OUTPUT -d 37.187.119.60 -p tcp -m multiport --dports 80,443 -j DROP
iptables -A INPUT -s 10.0.2.100 -p tcp --dport 3306 -j ACCEPT
iptables -A OUTPUT -d 10.0.2.100 -p tcp --sport 3306 -j ACCEPT
echo "Firewall configurado correctamente"
iptables -L -v -n