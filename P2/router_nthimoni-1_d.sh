#!/bin/bash

ip link add br0 type bridge
ip link set dev br0 up
ip addr add 10.1.1.1/24 dev eth0 
ip link add name vxlan10 type vxlan id 10 dev eth0 group 239.1.1.1 dstport 7348 
ip addr add 20.1.1.1/24 dev vxlan10
brctl addif br0 eth1
brctl addif br0 vxlan10 
ip link set dev vxlan10 up
ip -d link show vxlan10


