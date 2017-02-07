#!/usr/bin/env bash
ip=192.168.1.155
ruser=root@$ip

dir=$(pwd)
echo $dir

executable=$dir/bin/cmake
echo "  executable: $executable"
echo "  ruser: $ruser"

echo "stop gdbserver"
ssh ${ruser} killall gdbserver
ssh ${ruser} killall "${executable##/*/}"

echo "scp ${executable##/*/}"
scp ${executable} ${ruser}:/tmp/"${executable##/*/}"  #cp file

echo "Start remote gdb-server"
ssh -t ${ruser} gdbserver 192.168.1.126:2345 /tmp/"${executable##/*/}"  #  will output result

