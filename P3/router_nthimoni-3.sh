#!/bin/bash

touch /etc/frr/frr.conf
echo 'no ipv6 forwarding' > /etc/frr/frr.conf
echo 'interface eth1' >> /etc/frr/frr.conf
echo 'ip addr 10.1.1.6/30' >> /etc/frr/frr.conf
echo 'ip ospf area 0' >> /etc/frr/frr.conf
echo 'interface lo' >> /etc/frr/frr.conf
echo 'ip addr 1.1.1.3/32' >> /etc/frr/frr.conf
echo 'ip ospf area 0' >> /etc/frr/frr.conf
echo 'router bgp 1' >> /etc/frr/frr.conf
echo 'neighbor 1.1.1.1 remote-as 1' >> /etc/frr/frr.conf
echo 'neighbor 1.1.1.1 update-source lo' >> /etc/frr/frr.conf
echo 'address-family l2vpn evpn' >> /etc/frr/frr.conf
echo 'neighbor 1.1.1.1 activate' >> /etc/frr/frr.conf
echo 'exit-address-family' >> /etc/frr/frr.conf
echo 'router ospf' >> /etc/frr/frr.conf
vtysh -f /etc/frr/frr.conf

