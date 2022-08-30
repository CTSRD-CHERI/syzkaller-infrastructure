#!/bin/sh

address="morello7-bbb.sec.cl.cam.ac.uk"
username="zm322"
sshkey="~/ssh/zalan_key"

ssh $address -l $username -i $sshkey "sudo pkill -9 cu"
ssh $address -l $username -i $sshkey "printf '\nreboot\n~.' | sudo cu -s 115200 -l /dev/cuaU1"
