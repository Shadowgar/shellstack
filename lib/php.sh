#!/bin/bash

function install_php_fpm {
        log "Installing php fpm..."
	mkdir -p /var/www
	sudo add-apt-repository ppa:ondrej/php
	sudo apt-get install php7.3-fpm php7.3-cli php7.3-mysql php7.3-gd php7.3-imagick php7.3-recode php7.3-tidy php7.3-xmlrpc

	# php_fpm_conf_file=`grep -R "^listen.*=.*127" /etc/php/fpm/* | sed 's/:.*$//g' | uniq | head -n 1`
	# #sockets > ports. Using the 127.0.0.1:9000 stuff needlessly introduces TCP/IP overhead.
	# sed -i 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php5-fpm.sock/'  $php_fpm_conf_file

	# #sockets limited by net.core.somaxconn and listen.backlog to 128 by default, so increase this
	# #see http://www.saltwaterc.eu/nginx-php-fpm-for-high-loaded-websites.html
	# sed -i 's/^.*listen.backlog.*$/listen.backlog = 1024/g'                $php_fpm_conf_file
	# echo "net.core.somaxconn=1024" >/etc/sysctl.d/10-unix-sockets.conf
	# sysctl net.core.somaxconn=1024

	# #set max requests to deal with any possible memory leaks
	# #sed -i 's/^.*pm.max_requests.*$/pm.max_requests = 1024/g'              $php_fpm_conf_file
	# #/etc/init.d/php-fpm restart
}

function setup_php7.3_fpm_with_nginx {
  cat > /etc/nginx/sites-available/default << EOF
location ~ \.php$ {
include etc/nginx/snippets/fastcgi-php.conf;

# With php7.3-cgi alone:
# fastcgi_pass 127.0.0.1:9000;
# With php7.3-fpm:
#fastcgi_pass unix:/run/php/7.3/php7.3-fpm.sock;
}
EOF
}
