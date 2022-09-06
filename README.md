# Syzkaller host installation and run guide

## Installation

In your work directory clone cheribuild:
`git clone https://github.com/mazalan01/cheribuild`
and, clone cheribsd:
`git clone https://github.com/mazalan01/cheribsd`


To install the neccesery packages, run: `pkg install devel/autoconf devel/automake devel/bison devel/cmake devel/glib20 devel/gmake devel/libtool devel/llvm devel/ninja devel/pkgconf devel/py-flake8 devel/py-pytest editors/vim lang/go lang/python net/samba413 ports-mgmt/pkg print/texinfo shells/bash textproc/flex textproc/gsed x11/pixman`


Set your cheribuild confiurations, in details described in the cheribuild readme. An example with workdirectory `/fuzzing` is in `.config/cheribuild.json`. It is important to set `source-root` and `source-directory` correctly.


Build the neccesery targets:
- `./cheribuild.py cheribsd-morello-purecap -d`
- `./cheribuild.py disk-image-morello-purecap`
- `./cheribuild.py morello-syzkaller`


## Getting morellobox ready for fuzzing

Make sure morellobox has a cheribsd version with kcov and coverage, for example the `GENERIC-MORELLO-PURECAP-SYZAKLLER` kernel config.

It happend that syzfuzzer corrupted the file system, and cheribsd had to be reinstalled. To avoid this, you might want to run syzfuzzer in a tmpfs, and set root as a read-only file system.

## Run syzkaller

You can run syzkaller in cheribuild with the `./cheribuild.py run-morello-baremetal-syzkaller` command, but you have to specify a few arguments:
- use the `--run-morello-baremetal-syzkaller/ssh-user` flag to set the ssh username
- use the `--run-morello-baremetal-syzkaller/ssh-privkey` flag to set the path to the ssh private key
- use the `--run-morello-baremetal-syzkaller/morellobox-address` flag to set the address of the morellobox
- use the `--run-morello-baremetal-syzkaller/reboot-comamnd` flag to set the command that reboots the morellobox. 

The included `run_syzkaller.sh` is a script that starts syzkaller, and saves stdout and stderr in a directory called `logs` inside the user's home directory. The variables set at the beggining are an example, you have to change it for your use case. For the reboot command, it runs `reboot_morello.sh` which is another script included. You have to modify that as well, so it uses correct ssh configuration.

## Reproducing logs manually

The official documentation:[reproducing_crashes](https://github.com/google/syzkaller/blob/master/docs/reproducing_crashes.md)

The `upload_repro_files.sh` script uploads the files neccesery to reproduce logs (first change variables at the beggining of the file). The fist argument of the script should be the path to the log file, that you want to reproduce.

To run a log, on the box execute: `sudo env GODEBUG=asyncpreemptoff=1 ./syz-execprog -executor=./syz-executor -debug=true log_name`



