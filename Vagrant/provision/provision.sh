#!/usr/bin/env bash
#General Server Config
echo Provisioning Vagrant Box!

#update packacke lists
sudo nginx=stable # use nginx=development for latest development version
sudo add-apt-repository ppa:nginx/$nginx

#update packages
sudo apt-get update
sudo apt-get install -y wget curl git vim nginx

#mysql
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password abc123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password abc123'
sudo apt-get install -y mysql-server-5.6

#php
sudo apt-get install -y memcached php5-mysql php5-fpm php5-mcrypt php5-cli php5-curl php5-gd php5-json php5-memcache php5-memcached php5-gmp
sudo php5enmod mcrypt

#composer
if command -v composer 2>/dev/null; then
    echo Composer is already installed!
else
    sudo curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
fi

#ruby
if command -v ruby 2>/dev/null; then
    echo Ruby is already installed!
else
    sudo curl -sSL https://get.rvm.io | bash -s $1
    source ~/.rvm/scripts/rvm
    rvm install 2.2.1
    rvm use 2.2.1
fi

#node
if command -v node 2>/dev/null; then
    echo Node is already installed...updating!
    sudo apt-get install -y nodejs
else
    sudo curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash
    sudo apt-get install -y nodejs
fi

#gulp
if command -v gulp 2>/dev/null; then
    echo Gulp is already installed!
else
    sudo npm install -g gulp-cli
fi

##Copy Nginx Configs
sudo cp /vagrant/provision/nginx/* /etc/nginx/conf.d/

##change nginx runtime user to vagrant
sudo sed -i 's/user = www-data/user = vagrant/g' /etc/php5/fpm/pool.d/www.conf
sudo sed -i 's/group = www-data/group = vagrant/g' /etc/php5/fpm/pool.d/www.conf

##restart nginx & php
sudo service php5-fpm restart
sudo service nginx restart