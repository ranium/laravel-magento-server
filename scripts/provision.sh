#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Update Package List

apt-get update

# Update System Packages
apt-get -y upgrade

# Force Locale

echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale
locale-gen en_US.UTF-8

# Install Some PPAs

apt-get install -y software-properties-common curl
apt-add-repository ppa:nginx/development -y
apt-add-repository ppa:ondrej/php -y

curl -s https://packagecloud.io/gpg.key | apt-key add -
echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list

curl --silent --location https://deb.nodesource.com/setup_8.x | bash -

# Update Package Lists
apt-get update

# Install Some Basic Packages

apt-get install -y build-essential dos2unix gcc git libmcrypt4 libpcre3-dev libpng-dev ntp unzip \
make python2.7-dev python-pip re2c supervisor unattended-upgrades whois vim libnotify-bin \
pv cifs-utils mcrypt bash-completion zsh graphviz

# Set My Timezone

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# Install PHP Stuffs
# Current PHP
apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
php7.2-cli php7.2-dev \
php7.2-pgsql php7.2-sqlite3 php7.2-gd \
php7.2-curl php7.2-memcached \
php7.2-imap php7.2-mysql php7.2-mbstring \
php7.2-xml php7.2-zip php7.2-bcmath php7.2-soap \
php7.2-intl php7.2-readline php7.2-ldap \
php-xdebug php-pear

# PHP 7.3
apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
php7.3-cli php7.3-dev \
php7.3-pgsql php7.3-sqlite3 php7.3-gd \
php7.3-curl \
php7.3-imap php7.3-mysql php7.3-mbstring \
php7.3-xml php7.3-zip php7.3-bcmath php7.3-soap \
php7.3-intl php7.3-readline

# PHP 7.1
apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
php7.1-cli php7.1-dev \
php7.1-pgsql php7.1-sqlite3 php7.1-gd \
php7.1-curl php7.1-memcached \
php7.1-imap php7.1-mysql php7.1-mbstring \
php7.1-xml php7.1-zip php7.1-bcmath php7.1-soap \
php7.1-intl php7.1-readline

# PHP 7.0
apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
php7.0-cli php7.0-dev \
php7.0-pgsql php7.0-sqlite3 php7.0-gd \
php7.0-curl php7.0-memcached \
php7.0-imap php7.0-mysql php7.0-mbstring \
php7.0-xml php7.0-zip php7.0-bcmath php7.0-soap \
php7.0-intl php7.0-readline

# PHP 5.6
apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
php5.6-cli php5.6-dev \
php5.6-pgsql php5.6-sqlite3 php5.6-gd \
php5.6-curl php5.6-memcached \
php5.6-imap php5.6-mysql php5.6-mbstring \
php5.6-xml php5.6-zip php5.6-bcmath php5.6-soap \
php5.6-intl php5.6-readline php5.6-mcrypt

update-alternatives --set php /usr/bin/php7.2
update-alternatives --set php-config /usr/bin/php-config7.2
update-alternatives --set phpize /usr/bin/phpize7.2

# Install Composer

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install Laravel Envoy & Installer

sudo su vagrant <<'EOF'
/usr/local/bin/composer global require "laravel/envoy=~1.0"
/usr/local/bin/composer global require "laravel/installer=~2.0"
/usr/local/bin/composer global require "laravel/lumen-installer=~1.0"
/usr/local/bin/composer global require "laravel/spark-installer=~2.0"
EOF

# Set Some PHP CLI Settings
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.2/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.2/cli/php.ini

sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.3/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.3/cli/php.ini

sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.1/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.1/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.1/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.1/cli/php.ini

sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.0/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.0/cli/php.ini

sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/5.6/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/5.6/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/5.6/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/5.6/cli/php.ini

# Install Nginx & PHP-FPM

apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
nginx php7.1-fpm php7.3-fpm php7.2-fpm php7.0-fpm php5.6-fpm

rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default

# Create a configuration file for Nginx overrides.
sudo mkdir -p /home/vagrant/.config/nginx
sudo chown -R vagrant:vagrant /home/vagrant
touch /home/vagrant/.config/nginx/nginx.conf
sudo ln -sf /home/vagrant/.config/nginx/nginx.conf /etc/nginx/conf.d/nginx.conf

# Setup Some PHP-FPM Options
echo "xdebug.remote_enable = 1" >> /etc/php/7.2/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php/7.2/mods-available/xdebug.ini
echo "xdebug.remote_port = 9000" >> /etc/php/7.2/mods-available/xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/php/7.2/mods-available/xdebug.ini
echo "opcache.revalidate_freq = 0" >> /etc/php/7.2/mods-available/opcache.ini

echo "xdebug.remote_enable = 1" >> /etc/php/7.3/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php/7.3/mods-available/xdebug.ini
echo "xdebug.remote_port = 9000" >> /etc/php/7.3/mods-available/xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/php/7.3/mods-available/xdebug.ini
echo "opcache.revalidate_freq = 0" >> /etc/php/7.3/mods-available/opcache.ini

echo "xdebug.remote_enable = 1" >> /etc/php/7.1/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php/7.1/mods-available/xdebug.ini
echo "xdebug.remote_port = 9000" >> /etc/php/7.1/mods-available/xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/php/7.1/mods-available/xdebug.ini
echo "opcache.revalidate_freq = 0" >> /etc/php/7.1/mods-available/opcache.ini

echo "xdebug.remote_enable = 1" >> /etc/php/7.0/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php/7.0/mods-available/xdebug.ini
echo "xdebug.remote_port = 9000" >> /etc/php/7.0/mods-available/xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/php/7.0/mods-available/xdebug.ini
echo "opcache.revalidate_freq = 0" >> /etc/php/7.0/mods-available/opcache.ini

echo "xdebug.remote_enable = 1" >> /etc/php/5.6/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php/5.6/mods-available/xdebug.ini
echo "xdebug.remote_port = 9000" >> /etc/php/5.6/mods-available/xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/php/5.6/mods-available/xdebug.ini
echo "opcache.revalidate_freq = 0" >> /etc/php/5.6/mods-available/opcache.ini

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.2/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/fpm/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.2/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.2/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.2/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.2/fpm/php.ini

printf "[openssl]\n" | tee -a /etc/php/7.2/fpm/php.ini
printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.2/fpm/php.ini

printf "[curl]\n" | tee -a /etc/php/7.2/fpm/php.ini
printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.2/fpm/php.ini

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/fpm/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.3/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.3/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.3/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.3/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.3/fpm/php.ini

printf "[openssl]\n" | tee -a /etc/php/7.3/fpm/php.ini
printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.3/fpm/php.ini

printf "[curl]\n" | tee -a /etc/php/7.3/fpm/php.ini
printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.3/fpm/php.ini

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.1/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.1/fpm/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.1/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.1/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.1/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.1/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.1/fpm/php.ini

printf "[openssl]\n" | tee -a /etc/php/7.1/fpm/php.ini
printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.1/fpm/php.ini

printf "[curl]\n" | tee -a /etc/php/7.1/fpm/php.ini
printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.1/fpm/php.ini

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/fpm/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.0/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.0/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.0/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.0/fpm/php.ini

printf "[curl]\n" | tee -a /etc/php/7.0/fpm/php.ini
printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.0/fpm/php.ini

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/5.6/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/5.6/fpm/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/5.6/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/5.6/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/5.6/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/5.6/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/5.6/fpm/php.ini

printf "[curl]\n" | tee -a /etc/php/5.6/fpm/php.ini
printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/5.6/fpm/php.ini

# Disable XDebug On The CLI

sudo phpdismod -s cli xdebug

# Copy fastcgi_params to Nginx because they broke it on the PPA

cat > /etc/nginx/fastcgi_params << EOF
fastcgi_param	QUERY_STRING		\$query_string;
fastcgi_param	REQUEST_METHOD		\$request_method;
fastcgi_param	CONTENT_TYPE		\$content_type;
fastcgi_param	CONTENT_LENGTH		\$content_length;
fastcgi_param	SCRIPT_FILENAME		\$request_filename;
fastcgi_param	SCRIPT_NAME		\$fastcgi_script_name;
fastcgi_param	REQUEST_URI		\$request_uri;
fastcgi_param	DOCUMENT_URI		\$document_uri;
fastcgi_param	DOCUMENT_ROOT		\$document_root;
fastcgi_param	SERVER_PROTOCOL		\$server_protocol;
fastcgi_param	GATEWAY_INTERFACE	CGI/1.1;
fastcgi_param	SERVER_SOFTWARE		nginx/\$nginx_version;
fastcgi_param	REMOTE_ADDR		\$remote_addr;
fastcgi_param	REMOTE_PORT		\$remote_port;
fastcgi_param	SERVER_ADDR		\$server_addr;
fastcgi_param	SERVER_PORT		\$server_port;
fastcgi_param	SERVER_NAME		\$server_name;
fastcgi_param	HTTPS			\$https if_not_empty;
fastcgi_param	REDIRECT_STATUS		200;
EOF

# Set The Nginx & PHP-FPM User

sed -i "s/user www-data;/" /etc/nginx/nginx.conf
sed -i "s/# server_names_hash_bucket_size.*/server_names_hash_bucket_size 64;/" /etc/nginx/nginx.conf

sed -i "s/user = www-data/user = www-data/" /etc/php/7.2/fpm/pool.d/www.conf
sed -i "s/group = www-data/group = www-data/" /etc/php/7.2/fpm/pool.d/www.conf

sed -i "s/listen\.owner.*/listen.owner = www-data/" /etc/php/7.2/fpm/pool.d/www.conf
sed -i "s/listen\.group.*/listen.group = www-data/" /etc/php/7.2/fpm/pool.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.2/fpm/pool.d/www.conf

sed -i "s/user = www-data/user = www-data/" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/group = www-data/group = www-data/" /etc/php/7.3/fpm/pool.d/www.conf

sed -i "s/listen\.owner.*/listen.owner = www-data/" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/listen\.group.*/listen.group = www-data/" /etc/php/7.3/fpm/pool.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.3/fpm/pool.d/www.conf

sed -i "s/user = www-data/user = www-data/" /etc/php/7.1/fpm/pool.d/www.conf
sed -i "s/group = www-data/group = www-data/" /etc/php/7.1/fpm/pool.d/www.conf

sed -i "s/listen\.owner.*/listen.owner = www-data/" /etc/php/7.1/fpm/pool.d/www.conf
sed -i "s/listen\.group.*/listen.group = www-data/" /etc/php/7.1/fpm/pool.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.1/fpm/pool.d/www.conf

sed -i "s/user = www-data/user = www-data/" /etc/php/7.0/fpm/pool.d/www.conf
sed -i "s/group = www-data/group = www-data/" /etc/php/7.0/fpm/pool.d/www.conf

sed -i "s/listen\.owner.*/listen.owner = www-data/" /etc/php/7.0/fpm/pool.d/www.conf
sed -i "s/listen\.group.*/listen.group = www-data/" /etc/php/7.0/fpm/pool.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.0/fpm/pool.d/www.conf

sed -i "s/user = www-data/user = www-data/" /etc/php/5.6/fpm/pool.d/www.conf
sed -i "s/group = www-data/group = www-data/" /etc/php/5.6/fpm/pool.d/www.conf

sed -i "s/listen\.owner.*/listen.owner = www-data/" /etc/php/5.6/fpm/pool.d/www.conf
sed -i "s/listen\.group.*/listen.group = www-data/" /etc/php/5.6/fpm/pool.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/5.6/fpm/pool.d/www.conf

service nginx restart
service php7.2-fpm restart
service php7.3-fpm restart
service php7.1-fpm restart
service php7.0-fpm restart
service php5.6-fpm restart

#create a directory to avoid further error in nginx conf

mkdir /var/www/$1

sudo tee /var/www/$1/index.php << EOL 
<?php 
echo "You are in Homestead Environment";
phpinfo();
?>
EOL

cd .. 
cd sample_config/

#move magento's modified sample nginx file to /var/www

sudo mv nginx.conf.sample /var/www/

#create nginx config files in sites-available

sudo tee /etc/nginx/sites-available/backend.php56.com << EOL
server {
       listen 80;
       listen [::]:80;
       # SSL CONFIGS
       # listen 443 ssl;
       # listen [::]:443 ssl;
       # include snippets/self-signed.conf;
       # include snippets/ssl-params.conf;

        server_name ~^(?<subdomain>\w+)\.backendphp56\.com\$;
        set \$MAGE_ROOT /var/www/\$subdomain;
        set \$MAGE_MODE developer;
        
        location ~* \.php\$ {
                # With php-fpm unix sockets
                fastcgi_pass    unix:/run/php/php5.6-fpm.sock;
                include         fastcgi_params;
                fastcgi_param   SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;
                fastcgi_param   SCRIPT_NAME        \$fastcgi_script_name;
        }
        include /var/www/nginx.conf.sample;
}
EOL

sudo tee /etc/nginx/sites-available/frontend.php56.com << EOL
server {
    listen 80;
    listen [::]:80;
    server_name ~^(?<subdomain>\w+)\.frontendphp56\.co\.uk\$;
    root /var/www/\$subdomain/public;
    index  index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php\$query_string;
        }

    location ~ \.php\$ {
       include snippets/fastcgi-php.conf;
       fastcgi_pass    unix:/run/php/php5.6-fpm.sock;
       fastcgi_param   SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
   }

}
EOL

sudo tee /etc/nginx/sites-available/backend.php70.com << EOL
server {
       listen 80;
       listen [::]:80;
       # SSL CONFIGS
       # listen 443 ssl;
       # listen [::]:443 ssl;
       # include snippets/self-signed.conf;
       # include snippets/ssl-params.conf;

        server_name ~^(?<subdomain>\w+)\.backendphp70\.com\$;
        set \$MAGE_ROOT /var/www/\$subdomain;
        set \$MAGE_MODE developer;
        
        location ~* \.php\$ {
                # With php-fpm unix sockets
                fastcgi_pass    unix:/run/php/php7.0-fpm.sock;
                include         fastcgi_params;
                fastcgi_param   SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;
                fastcgi_param   SCRIPT_NAME        \$fastcgi_script_name;
        }
        include /var/www/nginx.conf.sample;
}
EOL

sudo tee /etc/nginx/sites-available/frontend.php70.com << EOL
server {
    listen 80;
    listen [::]:80;
    server_name ~^(?<subdomain>\w+)\.frontendphp70\.co\.uk\$;
    root /var/www/\$subdomain/public;
    index  index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php\$query_string;
        }

    location ~ \.php\$ {
       include snippets/fastcgi-php.conf;
       fastcgi_pass    unix:/run/php/php7.0-fpm.sock;
       fastcgi_param   SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
   }

}
EOL

sudo tee /etc/nginx/sites-available/backend.php71.com << EOL
server {
       listen 80;
       listen [::]:80;
       # SSL CONFIGS
       # listen 443 ssl;
       # listen [::]:443 ssl;
       # include snippets/self-signed.conf;
       # include snippets/ssl-params.conf;

        server_name ~^(?<subdomain>\w+)\.backendphp71\.com\$;
        set \$MAGE_ROOT /var/www/\$subdomain;
        set \$MAGE_MODE developer;
        
        location ~* \.php\$ {
                # With php-fpm unix sockets
                fastcgi_pass    unix:/run/php/php7.1-fpm.sock;
                include         fastcgi_params;
                fastcgi_param   SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;
                fastcgi_param   SCRIPT_NAME        \$fastcgi_script_name;
        }
        include /var/www/nginx.conf.sample;
}
EOL

sudo tee /etc/nginx/sites-available/frontend.php71.com << EOL
server {
    listen 80;
    listen [::]:80;
    server_name ~^(?<subdomain>\w+)\.frontendphp71\.co\.uk\$;
    root /var/www/\$subdomain/public;
    index  index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php\$query_string;
        }

    location ~ \.php\$ {
       include snippets/fastcgi-php.conf;
       fastcgi_pass    unix:/run/php/php7.1-fpm.sock;
       fastcgi_param   SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
   }

}
EOL

sudo tee /etc/nginx/sites-available/backend.php72.com << EOL
server {
       listen 80;
       listen [::]:80;
       # SSL CONFIGS
       # listen 443 ssl;
       # listen [::]:443 ssl;
       # include snippets/self-signed.conf;
       # include snippets/ssl-params.conf;

        server_name ~^(?<subdomain>\w+)\.backendphp72\.com\$;
        set \$MAGE_ROOT /var/www/\$subdomain;
        set \$MAGE_MODE developer;

        location ~* \.php\$ {
                # With php-fpm unix sockets
                fastcgi_pass    unix:/run/php/php7.2-fpm.sock;
                include         fastcgi_params;
                fastcgi_param   SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;
                fastcgi_param   SCRIPT_NAME        \$fastcgi_script_name;
        }
        include /var/www/nginx.conf.sample;
}
EOL

sudo tee /etc/nginx/sites-available/frontend.php72.com << EOL
server {
    listen 80;
    listen [::]:80;
    server_name ~^(?<subdomain>\w+)\.frontendphp72\.co\.uk\$;
    root /var/www/\$subdomain/public;
    index  index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php\$query_string;
        }

    location ~ \.php\$ {
       include snippets/fastcgi-php.conf;
       fastcgi_pass    unix:/run/php/php7.2-fpm.sock;
       fastcgi_param   SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
   }

}
EOL

sudo tee /etc/nginx/sites-available/backend.php73.com << EOL
server {
       listen 80;
       listen [::]:80;
       # SSL CONFIGS
       # listen 443 ssl;
       # listen [::]:443 ssl;
       # include snippets/self-signed.conf;
       # include snippets/ssl-params.conf;

        server_name ~^(?<subdomain>\w+)\.backendphp73\.com\$;
        set \$MAGE_ROOT /var/www/\$subdomain;
        set \$MAGE_MODE developer;

        location ~* \.php\$ {
                # With php-fpm unix sockets
                fastcgi_pass    unix:/run/php/php7.3-fpm.sock;
                include         fastcgi_params;
                fastcgi_param   SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;
                fastcgi_param   SCRIPT_NAME        \$fastcgi_script_name;
        }
        include /var/www/nginx.conf.sample;
}
EOL

sudo tee /etc/nginx/sites-available/frontend.php73.com << EOL
server {
    listen 80;
    listen [::]:80;
    server_name ~^(?<subdomain>\w+)\.frontendphp73\.co\.uk\$;
    root /var/www/\$subdomain/public;
    index  index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php\$query_string;
        }

    location ~ \.php\$ {
       include snippets/fastcgi-php.conf;
       fastcgi_pass    unix:/run/php/php7.3-fpm.sock;
       fastcgi_param   SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
   }

}
EOL

#create symlink to sites-enabled folder

sudo ln -s /etc/nginx/sites-available/backend.php56.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/backend.php70.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/backend.php71.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/backend.php72.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/backend.php73.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/frontend.php56.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/frontend.php70.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/frontend.php71.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/frontend.php72.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/frontend.php73.com /etc/nginx/sites-enabled/

#check if it is all ok
sudo nginx -t

sudo /etc/init.d/php5.6-fpm restart
sudo /etc/init.d/php7.0-fpm restart
sudo /etc/init.d/php7.1-fpm restart
sudo /etc/init.d/php7.2-fpm restart
sudo /etc/init.d/php7.3-fpm restart
sudo /etc/init.d/nginx restart

sudo printf "127.0.0.1  $1.backendphp56.com\n" | tee -a /etc/hosts
sudo printf "127.0.0.1  $1.backendphp70.com\n" | tee -a /etc/hosts
sudo printf "127.0.0.1  $1.backendphp71.com\n" | tee -a /etc/hosts
sudo printf "127.0.0.1  $1.backendphp72.com\n" | tee -a /etc/hosts
sudo printf "127.0.0.1  $1.backendphp73.com\n" | tee -a /etc/hosts
sudo printf "127.0.0.1  $1.frontendphp56.com\n" | tee -a /etc/hosts
sudo printf "127.0.0.1  $1.frontendphp70.com\n" | tee -a /etc/hosts
sudo printf "127.0.0.1  $1.frontendphp71.com\n" | tee -a /etc/hosts
sudo printf "127.0.0.1  $1.frontendphp72.com\n" | tee -a /etc/hosts
sudo printf "127.0.0.1  $1.frontendphp73.com\n" | tee -a /etc/hosts

# Install Mcrypt module

sudo apt-get install mcrypt php7.0-mcrypt php7.1-mcrypt php5.6-mcrypt


# Add Vagrant User To WWW-Data

usermod -a -G www-data vagrant
id vagrant
groups vagrant

# Install Node

apt-get install -y nodejs
/usr/bin/npm install -g npm
/usr/bin/npm install -g gulp-cli
/usr/bin/npm install -g bower
/usr/bin/npm install -g yarn
/usr/bin/npm install -g grunt-cli

# Install SQLite

apt-get install -y sqlite3 libsqlite3-dev

# Install MySQL
echo "mysql-server mysql-server/root_password password secret" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password secret" | debconf-set-selections
apt-get install -y mysql-server

# Configure MySQL Password Lifetime

echo "default_password_lifetime = 0" >> /etc/mysql/mysql.conf.d/mysqld.cnf

# Configure MySQL Remote Access

sed -i '/^bind-address/s/bind-address.*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

mysql --user="root" --password="secret" -e "GRANT ALL ON *.* TO root@'0.0.0.0' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
service mysql restart

mysql --user="root" --password="secret" -e "CREATE USER 'homestead'@'0.0.0.0' IDENTIFIED BY 'secret';"
mysql --user="root" --password="secret" -e "GRANT ALL ON *.* TO 'homestead'@'0.0.0.0' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
mysql --user="root" --password="secret" -e "GRANT ALL ON *.* TO 'homestead'@'%' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
mysql --user="root" --password="secret" -e "FLUSH PRIVILEGES;"
mysql --user="root" --password="secret" -e "CREATE DATABASE homestead character set UTF8mb4 collate utf8mb4_bin;"

sudo tee /home/vagrant/.my.cnf <<EOL
[mysqld]
character-set-server=utf8mb4
collation-server=utf8mb4_bin
EOL

# Add Timezone Support To MySQL

mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql --user=root --password=secret mysql

service mysql restart

# Install Postgres

apt-get install -y postgresql-10

# Configure Postgres Remote Access

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/10/main/postgresql.conf
echo "host    all             all             10.0.2.2/32               md5" | tee -a /etc/postgresql/10/main/pg_hba.conf
sudo -u postgres psql -c "CREATE ROLE homestead LOGIN PASSWORD 'secret' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"
sudo -u postgres /usr/bin/createdb --echo --owner=homestead homestead
service postgresql restart

# Install Blackfire

apt-get install -y blackfire-agent blackfire-php

# Install Zend Z-Ray (for FPM only, not CLI)

sudo wget http://repos.zend.com/zend-server/early-access/ZRay-Homestead/zray-standalone-php72.tar.gz -O - | sudo tar -xzf - -C /opt
sudo chown -R vagrant:vagrant /opt/zray

# Install The Chrome Web Driver & Dusk Utilities

apt-get -y install libxpm4 libxrender1 libgtk2.0-0 \
libnss3 libgconf-2-4 chromium-browser \
xvfb gtk2-engines-pixbuf xfonts-cyrillic \
xfonts-100dpi xfonts-75dpi xfonts-base \
xfonts-scalable imagemagick x11-apps

# Install Memcached & Beanstalk

apt-get install -y redis-server memcached beanstalkd

# Configure Beanstalkd

sed -i "s/#START=yes/START=yes/" /etc/default/beanstalkd
/etc/init.d/beanstalkd start

# Install & Configure MailHog

wget --quiet -O /usr/local/bin/mailhog https://github.com/mailhog/MailHog/releases/download/v0.2.1/MailHog_linux_amd64
chmod +x /usr/local/bin/mailhog

sudo tee /etc/systemd/system/mailhog.service <<EOL
[Unit]
Description=Mailhog
After=network.target

[Service]
User=vagrant
ExecStart=/usr/bin/env /usr/local/bin/mailhog > /dev/null 2>&1 &

[Install]
WantedBy=multi-user.target
EOL

systemctl daemon-reload
systemctl enable mailhog

# Configure Supervisor

systemctl enable supervisor.service
service supervisor start

# Install Crystal Programming Language Support
apt-key adv --keyserver hkp://keys.gnupg.net:80 --recv-keys 09617FD37CC06B54
echo "deb https://dist.crystal-lang.org/apt crystal main" | tee /etc/apt/sources.list.d/crystal.list
apt-get update
apt-get install -y crystal

# Install Heroku CLI

curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Install ngrok

wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip -d /usr/local/bin
rm -rf ngrok-stable-linux-amd64.zip

# Install Flyway

wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/4.2.0/flyway-commandline-4.2.0-linux-x64.tar.gz
tar -zxvf flyway-commandline-4.2.0-linux-x64.tar.gz -C /usr/local
chmod +x /usr/local/flyway-4.2.0/flyway
ln -s /usr/local/flyway-4.2.0/flyway /usr/local/bin/flyway
rm -rf flyway-commandline-4.2.0-linux-x64.tar.gz

# Install wp-cli

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Install Drush Launcher.

curl --silent --location https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar --output drush.phar
chmod +x drush.phar
mv drush.phar /usr/local/bin/drush
drush self-update

# Install Drupal Console Launcher.

curl --silent --location https://drupalconsole.com/installer --output drupal.phar
chmod +x drupal.phar
mv drupal.phar /usr/local/bin/drupal

# Install Golang

golangVersion="1.11.2"
wget https://dl.google.com/go/go${golangVersion}.linux-amd64.tar.gz -O golang.tar.gz
tar -C /usr/local -xzf golang.tar.gz
printf "\nPATH=\"/usr/local/go/bin:\$PATH\"\n" | tee -a /home/vagrant/.profile
rm -rf golang.tar.gz

# Install & Configure Postfix

echo "postfix postfix/mailname string homestead.test" | debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
apt-get install -y postfix
sed -i "s/relayhost =/relayhost = [localhost]:1025/g" /etc/postfix/main.cf
/etc/init.d/postfix reload

# Install .net core

wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt-get -y install apt-transport-https
sudo apt-get update
sudo apt-get -y install dotnet-sdk-2.1
sudo rm -rf packages-microsoft-prod.deb

# Update / Override motd

sed -i "s/motd.ubuntu.com/homestead.joeferguson.me/g" /etc/default/motd-news
rm -rf /etc/update-motd.d/10-help-text
rm -rf /etc/update-motd.d/50-landscape-sysinfo
service motd-news restart

# Install Ruby & RVM

apt-get -y install libssl-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common \
libffi-dev rbenv

git clone https://github.com/rbenv/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bashrc
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/vagrant/.bashrc
exec $SHELL

rbenv install 2.5.3
rbenv global 2.5.3
apt-get -y install ruby`ruby -e 'puts RUBY_VERSION[/\d+\.\d+/]'`-dev
gem install rails -v 5.2.1

# One last upgrade check

apt-get -y upgrade

# Clean Up

apt-get -y autoremove
apt-get -y clean
chown -R vagrant:vagrant /home/vagrant

# Add Composer Global Bin To Path

printf "\nPATH=\"$(sudo su - vagrant -c 'composer config -g home 2>/dev/null')/vendor/bin:\$PATH\"\n" | tee -a /home/vagrant/.profile

# Enable Swap Memory

/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1


