#!/bin/sh

sshkey="/home/zalan/ssh/zalan_key"
sshuser="zm322"
morellobox_destination="morello7-dev.sec.cl.cam.ac.uk:/syz"
morello_bin="/home/zalan/cheri/morello-syzkaller/bin"

scpb="scp -i $sshkey"
dest="$sshuser@$morellobox_destination"
syzscp="$scpb $morello_bin"

$syzscp/freebsd_arm64/syz-fuzzer $dest
$syzscp/freebsd_arm64/syz-executor $dest
$syzscp/freebsd_arm64/syz-execprog $dest
$scpb $1 $dest
