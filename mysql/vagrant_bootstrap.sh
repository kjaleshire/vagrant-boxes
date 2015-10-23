# Some parts borrowed from https://github.com/rails/rails-dev-box/
# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    # Use noninteractive to avoid dialogs (eg mysql-server asking for password)
    sudo DEBIAN_FRONTEND=noninteractive apt-get -y install "$@"
}

# Make sure the system is using UTF-8
locale-gen en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

echo updating package information
sudo apt-get -y update
sudo apt-get -y upgrade

echo installing utilities
install utilities zerofree

# Install for Vivid
echo installing and configuring MySQL
install mysql mysql-client mysql-server
mysql -u root -e "GRANT ALL ON *.* to root@'10.%'"

sudo mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bak
sudo cp /vagrant/conf/mysqld.cnf /etc/mysql/mysql.conf.d/
sudo systemctl restart mysql

# cleanup
echo cleaning up
sudo apt-get clean
