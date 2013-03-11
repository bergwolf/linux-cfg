#! /bin/bash

for I in `seq 1 4`; do sudo lxc-stop -n plfs$I; done

for I in `seq 1 4`; do sudo lxc-destroy -n plfs$I; done
