#! /bin/bash

set -e

CONFIGDIR=/home/bergwolf/lxc/

for I in `seq 1 4`; do
sudo lxc-create -n plfs$I -t mysshd -f $CONFIGDIR/plfs_$I.conf
done

set +e
