FROM ubuntu:20.04

# ARG port

# Install Git, Apache2, PHP, and postfix
RUN apt update \
 && DEBIAN_FRONTEND=noninteractive apt install -y \
    git \
    apache2 \
    libapache2-mod-php \
    php-xml \
    postfix \
 && a2enmod rewrite

# Download Dokuwiki
RUN cd /var/www \
 && git clone -b release_stable_2022-07-31 https://github.com/splitbrain/dokuwiki.git \
 && chown -R www-data:www-data /var/www/dokuwiki

RUN sed -i "12s|DocumentRoot /var/www/html|DocumentRoot /var/www/dokuwiki|" /etc/apache2/sites-enabled/000-default.conf \
 && sed -i "172s|AllowOverride None|AllowOverride All|" /etc/apache2/apache2.conf
 # && sed -i "5s|^Listen 80|Listen $port|" /etc/apache2/ports.conf \
 # && sed -i "1s|VirtualHost \*\:80|VirtualHost \*\:$port|" /etc/apache2/sites-enabled/000-default.conf

# Launch script
WORKDIR "/root"
RUN printf '#!/bin/bash \
\n \
service apache2 reload \n \
service apache2 start \n \
if [[ -f /var/www/dokuwiki/install.php ]]; then\n \
    echo "delete /var/www/dokuwiki/install.php? [y/n]"\n \
    read yn\n \
    if [ "$yn" = "y" ]; then\n \
        rm /var/www/dokuwiki/install.php\n \
    fi\n \
fi\n \
sleep infinity' > launch.sh \
 && chmod +x launch.sh

ENTRYPOINT ["./launch.sh"]
