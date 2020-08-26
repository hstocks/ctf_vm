#!/bin/bash

# Updates
sudo apt-get -y update

# https://github.com/chef/bento/issues/661
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

sudo apt-get -y install python3-pip
sudo apt-get -y install screen
sudo apt-get -y install gdb gdb-multiarch
sudo apt-get -y install unzip
sudo apt-get -y install build-essential
sudo apt-get -y install unrar
sudo apt-get -y install htop
sudo apt-get -y install seccomp
sudo apt-get -y install libseccomp-dev

# QEMU with MIPS/ARM - http://reverseengineering.stackexchange.com/questions/8829/cross-debugging-for-mips-elf-with-qemu-toolchain
sudo apt-get -y install qemu qemu-user qemu-user-static
sudo apt-get -y install 'binfmt*'
sudo apt-get -y install libc6-armhf-armel-cross
# sudo apt-get -y install debian-keyring
# sudo apt-get -y install debian-archive-keyring
# sudo apt-get -y install emdebian-archive-keyring
# tee /etc/apt/sources.list.d/emdebian.list << EOF
# deb http://mirrors.mit.edu/debian squeeze main
# deb http://www.emdebian.org/debian squeeze main
# EOF
sudo apt-get -y install libc6-mipsel-cross
sudo apt-get -y install libc6-arm-cross
mkdir /etc/qemu-binfmt
ln -s /usr/mipsel-linux-gnu /etc/qemu-binfmt/mipsel
ln -s /usr/arm-linux-gnueabihf /etc/qemu-binfmt/arm
rm /etc/apt/sources.list.d/emdebian.list

# These are so the 64 bit vm can build 32 bit
sudo apt-get -y install libx32gcc-4.8-dev
sudo apt-get -y install libc6-dev-i386

# Install ARM binutils
sudo apt-get install binutils-arm-linux-gnueabi

# Install Pwntools
sudo apt-get -y install python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
sudo pip install --upgrade pip
sudo pip install --upgrade pwntools

cd
mkdir tools
cd tools

# Capstone for pwndbg
# git clone https://github.com/aquynh/capstone
# pushd capstone
# git checkout -t origin/next
# sudo ./make.sh install
# cd bindings/python
# sudo python3 setup.py install # Ubuntu 14.04+, GDB uses Python3
# popd

# Uninstall capstone
#sudo pip2 uninstall capstone -y

# Install correct capstone
#pushd capstone/bindings/python
#sudo python setup.py install
#popd

# Install binwalk
# git clone https://github.com/devttys0/binwalk
# pushd binwalk
# sudo python setup.py install
# popd

# Angr
sudo apt-get -y install python-dev libffi-dev build-essential virtualenvwrapper
sudo pip install virtualenv
virtualenv angr
source angr/bin/activate
pip install angr --upgrade
deactivate

# tmux
wget https://github.com/tmux/tmux/releases/download/3.0a/tmux-3.0a.tar.gz
tar -zxvf tmux-3.0a.tar.gz
pushd tmux-3.0a
sudo apt-get -y install libevent-dev
sudo apt-get -y install libncurses-dev
./configure && make -j`nproc` && sudo make install
popd
rm -rf tmux-3.0a.tar.gz
rm -rf tmux-3.0a

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# GEF
wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py
echo source ~/.gdbinit-gef.py >> ~/.gdbinit

# AFL Fuzzer
#wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz
#tar -zxvf afl-latest.tgz
#pushd afl-*
#make && sudo make install
#popd
#rm afl-latest.tgz

# Enable 32bit binaries on 64bit host
sudo dpkg --add-architecture i386
sudo apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
sudo apt-get -y install libc6:i386 libc6-dbg:i386 libncurses5:i386 libstdc++6:i386

# Z3
git clone https://github.com/Z3Prover/z3.git && cd z3
python scripts/mk_make.py --python
cd build; make -j2 && sudo make install

# Get glibc source
sudo apt-get -y install libc6-dbg glibc-source
pushd /usr/src/glibc/
sudo tar xvf glibc-2.*.tar.xz
popd

# Set search paths in gdb for debugging glibc
LIBC_SRC_PATH=$(find /usr/src/glibc/ -name "glibc-2.??")
echo set dir $LIBC_SRC_PATH/malloc/ >> ~/.gdbinit
echo set dir $LIBC_SRC_PATH/libio/ >> ~/.gdbinit
echo set dir $LIBC_SRC_PATH/stdio-common/ >> ~/.gdbinit

# one_gadget
sudo apt-get -y install ruby
sudo gem install one_gadget

# seccomp-tools
sudo apt-get -y install gcc ruby-dev
sudo gem install seccomp-tools

# ropper
sudo pip install ropper

# TODO:
# apktool
# java
# dotfiles/vimrc
