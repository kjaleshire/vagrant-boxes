# Some parts borrowed from https://github.com/rails/rails-dev-box/
# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    # Use noninteractive to avoid dialogs (eg mysql-server asking for password)
    sudo DEBIAN_FRONTEND=noninteractive apt-get -y install "$@"
}

# current xenial image (as of 8/09/16) is broken:
# https://bugs.launchpad.net/ubuntu/+source/livecd-rootfs/+bug/1561250
#
# need the following bootstrap code to make sure the hostname
# is in the hosts file:
if ! grep -q $(cat /etc/hostname) /etc/hosts; then
    sudo sh -c "echo >> /etc/hosts"
    sudo sh -c "echo 127.0.0.1 $(cat /etc/hostname) >> /etc/hosts"
fi

# Make sure the system is using UTF-8
locale-gen en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

echo updating package information
sudo apt-get -y update
sudo apt-get -y upgrade

#Install for Vivid
echo installing and configuring Redis
install redis redis-server

sudo mv /etc/redis/redis.conf /etc/redis/redis.conf.bak
sudo cp /vagrant/conf/redis.conf /etc/redis/
sudo systemctl restart redis-server

# cleanup
echo cleaning up
sudo apt-get clean
