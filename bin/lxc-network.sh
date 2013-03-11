#! /bin/bash

set -e

sudo /usr/sbin/brctl addbr br0
sudo /usr/sbin/brctl setfd br0 0
sudo /sbin/ifconfig br0 192.168.72.12 promisc up
sudo /usr/sbin/brctl addif br0 eth0
sudo /sbin/ifconfig eth0 0.0.0.0 up
sudo /sbin/route add -net default gw 192.168.72.2 br0

set +e
