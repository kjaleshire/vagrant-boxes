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

echo ">>>> updating package information"
sudo apt-get -y update
sudo apt-get -y upgrade

install utilities zerofree xorriso qemu nasm texinfo flex bison git python-dev ncurses-dev make

echo ">>>> installing rust toolchain"
curl https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-setup -o rustup-setup -sSf
chmod u+x rustup-setup
./rustup-setup -y
rm rustup-setup
echo "PATH=\$PATH:\$HOME/.cargo/bin" >> $HOME/.profile
source $HOME/.profile
rustup update stable
rustup update nightly
rustup default nightly
rustup target add arm-unknown-linux-gnueabihf
rustup target add armv7-unknown-linux-gnueabihf
rustup target add aarch64-unknown-linux-gnu
rustup target add armv7-apple-ios
rustup target add armv7s-apple-ios
rustup target add aarch64-apple-ios
rustup target add x86_64-apple-ios
rustup target add i386-apple-ios

# cleanup
echo ">>>> cleaning up"
sudo apt-get clean
