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
nginx=stable
sudo add-apt-repository ppa:nginx/$nginx
sudo apt-get -y update
sudo apt-get -y upgrade

echo installing utilities
install utilities zerofree

# Install for Vivid
echo installing and configuring Nginx
 # use nginx=development for latest development version
install nginx nginx

sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
sudo cp /vagrant/conf/nginx.conf /etc/nginx/nginx.conf

sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
sudo cp /vagrant/conf/sites/default /etc/nginx/sites-available/default

sudo systemctl reload nginx

# cleanup
echo cleaning up
sudo apt-get clean
