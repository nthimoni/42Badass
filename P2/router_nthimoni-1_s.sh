#!/bin/bash

#create a new network bridge interface 'br0'
ip link add br0 type bridge
#Active the bridge interface 'br0'
ip link set dev br0 up
#Assigns the IP address 10.1.1.1 with a subnet mask /24 (255.255.255.0) to the physical interface eth0
ip addr add 10.1.1.1/24 dev eth0 
#Creates a VXLAN interface named vxlan10
ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.2 local 10.1.1.1 dstport 7348 
#Assigns the IP address 20.1.1.1 with a subnet mask /24 to the vxlan10 interface
ip addr add 20.1.1.1/24 dev vxlan10
#Adds the physical interface eth1 to the bridge br0
brctl addif br0 eth1
#Adds the VXLAN interface vxlan10 to the bridge br0
brctl addif br0 vxlan10 
#Activates the VXLAN interface vxlan10
ip link set dev vxlan10 up


