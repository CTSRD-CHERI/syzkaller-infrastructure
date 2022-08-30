#!/bin/sh

hosthomedir="/home/zalan"
sshusername="zm322"
sshkey="/home/zalan/ssh/zalan_key"
morelloaddress="morello7-dev.sec.cl.cam.ac.uk"
cheribuildlocation="/home/zalan/cheribuild"
rebootcommand="timeout 1m /home/zalan/reboot_morello.sh"

filename="./logs/$(date +%Y%m%d-%H%M%S)_syzlog"
outfilename=$filename"_stdou.log"
errfilename=$filename"_stderr.log"

cd $hosthomedir

$cheribuildlocation/cheribuild.py run-morello-baremetal-syzkaller --run-morello-baremetal-syzkaller/ssh-user $sshusername --run-morello-baremetal-syzkaller/ssh-privkey $sshkey --run-morello-baremetal-syzkaller/morellobox-address $morelloaddress --run-morello-baremetal-syzkaller/reboot-command "$rebootcommand" -v 1>$outfilename 2>$errfilename
