# Some parts borrowed from https://github.com/rails/rails-dev-box/
# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    sudo pkgin -y install "$@"
}

# Make sure the system is using UTF-8
export LC_CTYPE="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

echo updating package information
sudo pkgin -y update
sudo pkgin -y upgrade

install utilities bash nano openssl nasm git qemu mozilla-rootcerts
sudo mozilla-rootcerts install

echo installing necessary junk for rump kernels
install stuff cdrkit cmake gtar gmake findutils coreutils libisoburn grub2

# cleanup
echo cleaning up
sudo pkgin clean
