#!/bin/bash
YUM=$(which yum)
#####
if [ "$YUM" ]; then
echo > /etc/sysctl.conf
##
tee -a /etc/sysctl.conf <<EOF
net.ipv6.conf.default.disable_ipv6 = 0
net.ipv6.conf.all.disable_ipv6 = 0
EOF
##
sysctl -p
IPC=$(curl -4 -s icanhazip.com | cut -d"." -f3)
IPD=$(curl -4 -s icanhazip.com | cut -d"." -f4)
##
if [ $IPC == 143 ]
then
   tee -a /etc/sysconfig/network-scripts/ifcfg-eth0 <<-EOF
	IPV6INIT=yes
	IPV6_AUTOCONF=no
	IPV6_DEFROUTE=yes
	IPV6_FAILURE_FATAL=no
	IPV6_ADDR_GEN_MODE=stable-privacy
	IPV6ADDR=2403:6a40:2:4100::$IPD:0000/56
	IPV6_DEFAULTGW=2403:6a40:2:4100::1
	EOF
 # Add any additional configuration steps here
fi

service network restart

rm -rf ipv6.sh

 echo 'Da tao IPV6 thanh cong!'
