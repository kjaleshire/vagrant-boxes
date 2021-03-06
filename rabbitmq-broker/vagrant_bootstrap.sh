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

install rabbitmq rabbitmq-server

echo installing rabbitmq config
sudo mv /etc/rabbitmq/rabbitmq-env.conf /etc/rabbitmq/rabbitmq-env.conf.bak
sudo cp /vagrant/conf/rabbitmq-env.conf /etc/rabbitmq/rabbitmq-env.conf
sudo cp /vagrant/conf/rabbitmq.config /etc/rabbitmq/rabbitmq.config
sudo systemctl restart rabbitmq-server

echo creating `vagrant` rabbitmq user
sudo rabbitmqctl delete_user guest
sudo rabbitmqctl add_user vagrant vagrant
sudo rabbitmqctl set_user_tags vagrant administrator
sudo rabbitmqctl set_permissions vagrant ".*" ".*" ".*"

echo enabling rabbitmq management plugin
sudo rabbitmq-plugins enable rabbitmq_management

# cleanup
echo cleaning up
sudo apt-get clean
