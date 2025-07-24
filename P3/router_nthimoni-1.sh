#!/bin/bash

touch /etc/frr/frr.conf
echo 'no ipv6 forwarding' > /etc/frr/frr.conf
#configure ethernet interface
echo 'int lo' >> /etc/frr/frr.conf
echo 'ip address 1.1.1.1/32' >> /etc/frr/frr.conf
#configure ethernet interface
echo 'int eth0' >> /etc/frr/frr.conf
echo 'ip address 10.1.1.1/30' >> /etc/frr/frr.conf
#configure ethernet interface
echo 'int eth1' >> /etc/frr/frr.conf
echo 'ip address 10.1.1.5/30' >> /etc/frr/frr.conf
#configure ethernet interface
echo 'int eth2' >> /etc/frr/frr.conf
echo 'ip address 10.1.1.9/30' >> /etc/frr/frr.conf
#Starts a BGP routing process with the Autonomous System (AS) number 1
echo 'router bgp 1' >> /etc/frr/frr.conf
#Defines a peer group named ibgp. A peer group simplifies configuration by allowing the same settings to apply to multiple neighbors.
echo 'neighbor ibgp peer-group' >> /etc/frr/frr.conf
#Specifies that all neighbors in the ibgp peer group belong to the same AS (1). This is an iBGP (internal BGP) configuration.
echo 'neighbor ibgp remote-as 1' >> /etc/frr/frr.conf
#Configures the loopback interface (lo) as the source IP for BGP sessions with neighbors in the ibgp peer group. This is common in scalable BGP configurations.
echo 'neighbor ibgp update-source lo' >> /etc/frr/frr.conf
#Configures BGP to automatically listen for neighbors within the IP range 1.1.1.0/29 and assigns them to the ibgp peer group.
echo 'bgp listen range 1.1.1.0/29 peer-group ibgp' >> /etc/frr/frr.conf
#Enters the configuration for the L2VPN EVPN address family, which is used for VXLAN (Virtual Extensible LAN) implementations.
echo 'address-family l2vpn evpn'>> /etc/frr/frr.conf
#Activates the ibgp peer group for the EVPN address family.
echo 'neighbor ibgp activate' >> /etc/frr/frr.conf
# Makes the neighbor a Route Reflector Client (receives but doesn't reflect routes).
echo 'neighbor ibgp route-reflector-client' >> /etc/frr/frr.conf
# Exits the EVPN address-family configuration, returning to global BGP settings.
echo 'exit-address-family' >> /etc/frr/frr.conf
# Starts the OSPF routing process on the router.
echo 'router ospf' >> /etc/frr/frr.conf
# Advertises all networks in OSPF area 0.
echo 'network 0.0.0.0/0 area 0' >> /etc/frr/frr.conf
# Enables remote access to the router via CLI (Telnet/SSH).
echo 'line vty' >> /etc/frr/frr.conf

vtysh -f /etc/frr/frr.conf
