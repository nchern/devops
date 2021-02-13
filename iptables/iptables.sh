#!/bin/sh
set -ue

# Source: https://bencane.com/2012/09/17/iptables-linux-firewall-rules-for-a-basic-web-server/

IPTABLES="iptables"
if [ "$1" -eq "6" ]; then
    IPTABLES="ip6tables"
fi

# Accept any related or established connections.
# Without this outgoing requests from the server will not quite work
$IPTABLES -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# Allow SSH traffic from all sources:
$IPTABLES -I INPUT -p tcp --dport 22 -j ACCEPT

# Allow Loopback Traffic
$IPTABLES -I INPUT -i lo -j ACCEPT

# Change the base policy to default deny (Explicit Allow)
$IPTABLES -P INPUT DROP

# Allow HTTP(S) 
$IPTABLES -A INPUT -p tcp --dport 80 -j ACCEPT
$IPTABLES -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow DNS Traffic. Withous --sport doesn't work
$IPTABLES -A INPUT -p tcp --dport 53 -j ACCEPT
$IPTABLES -A INPUT -p udp --dport 53 -j ACCEPT
$IPTABLES -A INPUT -p tcp --sport 53 -j ACCEPT
$IPTABLES -A INPUT -p udp --sport 53 -j ACCEPT

# Allow pings to this host
$IPTABLES -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
