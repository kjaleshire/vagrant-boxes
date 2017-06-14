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
sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu trusty universe'
sudo apt-get -y update
sudo apt-get -y upgrade

echo installing utilities
install utilities zerofree

# Install mysql
echo installing and configuring MySQL
install mysql mysql-client-5.6 mysql-server-5.6

sudo mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bak
sudo cp /vagrant/conf/mysqld.cnf /etc/mysql/mysql.conf.d/
sudo service mysql restart

sudo mysql -u root -e "GRANT ALL ON *.* to root@'10.%'"

# cleanup
echo cleaning up
sudo apt-get clean
