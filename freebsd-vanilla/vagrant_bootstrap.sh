#!/usr/bin/env sh

# Make sure the system is using UTF-8
export LC_CTYPE="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

echo updating package information
sudo pkg update
sudo pkg upgrade -y

echo installing utilities
pkg install -y utilities bash curl nano git nasm openssl qemu svn

sudo chsh -s /usr/local/bin/bash vagrant

cleanup
echo cleaning up
sudo pkg clean
