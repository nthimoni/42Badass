#!/bin/bash

# Did in P2 (vxlan Creation)
ip link add br0 type bridge
ip link set dev br0 up
ip link add vxlan10 type vxlan id 10 dstport 4789
ip link set dev vxlan10 up
brctl addif br0 vxlan10
brctl addif br0 eth1

touch /etc/frr/frr.conf
# Disable IPV6 Forwarding
echo 'no ipv6 forwarding' > /etc/frr/frr.conf
# Configure loopback interface (lo)
echo 'int lo' >> /etc/frr/frr.conf
# Assign ip address to the lo
echo 'ip address 1.1.1.2/32' >> /etc/frr/frr.conf
#  Configures the loopback interface to be part of OSPF area 0
echo 'ip ospf area 0' >> /etc/frr/frr.conf
# Configures the Ethernet interface eth0
echo 'int eth0' >> /etc/frr/frr.conf
#  Assigns the IP address 10.1.1.2/30 to the interface
echo 'ip address 10.1.1.2/30' >> /etc/frr/frr.conf
# Configures the ethernet interface to be part of the OSPF area 0
echo 'ip ospf area 0' >> /etc/frr/frr.conf
# Configures BGP -> starts the bgp routing process with ASN14
echo 'router bgp 1' >> /etc/frr/frr.conf
# Defines a BGP neighbor with IP address 1.1.1.1 and remote AS number 1
echo 'neighbor 1.1.1.1 remote-as 1' >> /etc/frr/frr.conf
# Sets the update source for the BGP neighbor to be the loopback interface (lo
echo 'neighbor 1.1.1.1 update-source lo' >> /etc/frr/frr.conf
# Enters the EVPN (Ethernet VPN) address family configuration
echo 'address-family l2vpn evpn'>> /etc/frr/frr.conf
# Activates the BGP session for EVPN with the neighbor 1.1.1.1
echo 'neighbor 1.1.1.1 activate' >> /etc/frr/frr.conf
# Advertises all VXLAN Network Identifiers (VNIs
echo 'advertise-all-vni' >> /etc/frr/frr.conf
# Exits the EVPN address-family configuration
echo 'exit-address-family' >> /etc/frr/frr.conf
# You should know bro :)
echo 'router ospf' >> /etc/frr/frr.conf
vtysh -f /etc/frr/frr.conf
