#!/usr/bin/env sh
# Some parts borrowed from https://github.com/rails/rails-dev-box/
# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    sudo pkg install -y "$@"
}

# Make sure the system is using UTF-8
export LC_CTYPE="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

echo updating package information
sudo pkg update
sudo pkg upgrade -y

echo installing utilities
install utilities bash curl nano git nasm openssl qemu

sudo chsh -s /usr/local/bin/bash vagrant

cleanup
echo cleaning up
sudo pkg clean
