#! /bin/bash

for I in `seq 1 4`; do sudo lxc-stop -n plfs$I; done

echo done
