#!/bin/bash

ip link add br0 type bridge
ip link set dev br0 up
ip link add vxlan10 type vxlan id 10 dstport 4789
ip link set dev vxlan10 up
brctl addif br0 vxlan10
brctl addif br0 eth0

touch /etc/frr/frr.conf
echo 'no ipv6 forwarding' > /etc/frr/frr.conf
echo 'int lo' >> /etc/frr/frr.conf
echo 'ip address 1.1.1.4/32' >> /etc/frr/frr.conf
echo 'ip ospf area 0' >> /etc/frr/frr.conf
echo 'int eth2' >> /etc/frr/frr.conf
echo 'ip address 10.1.1.10/30' >> /etc/frr/frr.conf
echo 'ip ospf area 0' >> /etc/frr/frr.conf
echo 'router bgp 1' >> /etc/frr/frr.conf
echo 'neighbor 1.1.1.1 remote-as 1' >> /etc/frr/frr.conf
echo 'neighbor 1.1.1.1 update-source lo' >> /etc/frr/frr.conf
echo 'address-family l2vpn evpn'>> /etc/frr/frr.conf
echo 'neighbor 1.1.1.1 activate' >> /etc/frr/frr.conf
echo 'advertise-all-vni' >> /etc/frr/frr.conf
echo 'exit-address-family' >> /etc/frr/frr.conf
echo 'router ospf' >> /etc/frr/frr.conf
vtysh -f /etc/frr/frr.conf
