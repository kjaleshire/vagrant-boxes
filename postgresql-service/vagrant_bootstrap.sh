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
# if ! grep -q $(cat /etc/hostname) /etc/hosts; then
#     sudo sh -c "echo >> /etc/hosts"
#     sudo sh -c "echo 127.0.0.1 $(cat /etc/hostname) >> /etc/hosts"
# fi

# Make sure the system is using UTF-8
locale-gen en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

echo updating package information
sudo apt-get -y update
sudo apt-get -y upgrade

install postgres postgresql

echo installing postgresql.conf
sudo mv /etc/postgresql/9.5/main/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf.bak
sudo cp /vagrant/conf/postgresql.conf /etc/postgresql/9.5/main/

echo installing pg_hba.conf
sudo mv /etc/postgresql/9.5/main/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf.bak
sudo cp /vagrant/conf/pg_hba.conf /etc/postgresql/9.5/main/

sudo systemctl restart postgresql

# echo creating default postgres role
# sudo -u postgres createuser --superuser vagrant
# sudo -u postgres createdb vagrant

# cleanup
echo cleaning up
sudo apt-get clean
