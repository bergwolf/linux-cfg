#! /bin/bash
#echo -1 >/proc/sys/lnet/debug
#echo 200 >/proc/sys/lnet/debug_mb
#echo 0 >/proc/sys/lnet/panic_on_lbug # This is needed to prevent kernel panic on lbug to gather log after the crash
#lctl dk >/dev/null # This is to clear current debug buffer
#now run the app
#After LBUG is hit, you will see a message in kernel log about "dumping log to /tmp/lustre...." get that log (and make a copy first!) and run
#lctl df /tmp/lustre... >/tmp/lustre...txt


echo -1 >/proc/sys/lnet/debug
echo 200 >/proc/sys/lnet/debug_mb
echo 0 >/proc/sys/lnet/panic_on_lbug
lctl dk >/dev/null
