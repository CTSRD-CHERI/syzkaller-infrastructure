# Syzkaller host installation and run guide

## Installation

In your work directory clone cheribuild:
`git clone https://github.com/mazalan01/cheribuild`
and, clone cheribsd:
`git clone https://github.com/mazalan01/cheribsd`


To install the neccesery packages, run: `pkg install devel/autoconf devel/automake devel/bison devel/cmake devel/glib20 devel/gmake devel/libtool devel/llvm devel/ninja devel/pkgconf devel/py-flake8 devel/py-pytest editors/vim lang/go lang/python net/samba413 ports-mgmt/pkg print/texinfo shells/bash textproc/flex textproc/gsed x11/pixman`


Set you cheribuild confiurations, in detail described in the cheribuild readme. An example with workdirectory `/fuzzing` is in `.config/cheribuild.json`. It is important to set `source-root` and `source-directory` correctly.

Install cheribsd in cheribuild with: `./cheribuild.py cheribsd-morello-purecap -d`

Build syzkaller in cheribuild with: `./cheribuild.py morello-syzkaller`

## Making morellobox ready for fuzzing

Make sure morellobox has a cheribsd version with kcov and coverage, for example the `GENERIC-MORELLO-PURECAP-SYZAKLLER` kernel config.

It happend that syzfuzzer corrupted the file system, and cheribsd had to be reinstalled. To avoid this, you might want to run syzfuzzer in a tmpfs, and set root as a read-only file system.

## Run syzkaller

You can run syzkaller in cheribuild with the `./cheribuild.py run-morello-baremetal-syzkaller` command, but you have to specify a few arguments:
- use the `--run-morello-baremetal-syzkaller/ssh-user` flag to set the ssh username
- use the `--run-morello-baremetal-syzkaller/ssh-privkey` flag to set the path to the ssh private key
- use the `--run-morello-baremetal-syzkaller/morellobox-address` flag to set the address of the morellobox

The included `run_syzkaller.sh` is a script that starts syzkaller, and saves stdout and stderr in a directory called `logs` inside the user's home directory. The variables set at the beggining are an example, you have to change it for your use case.
