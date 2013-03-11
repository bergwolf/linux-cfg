#! /bin/bash

set -e
for I in `seq 1 4`; do
	sudo lxc-start -n plfs$I -d
done

echo started...
set +e
