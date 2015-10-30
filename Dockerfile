FROM ubuntu:trusty

# update base system
RUN apt-get update && \
    apt-get -y dist-upgrade

# install nginx
RUN apt-get install -y software-properties-common && \
    add-apt-repository ppa:nginx/stable && \
    apt-get update && \
    apt-get install -y nginx

# create cache directories
RUN mkdir -p /srv/www/cache/installs && \
    mkdir -p /srv/www/cache/other && \
    mkdir -p /srv/www/cache/tmp

# add nginx configuration
ADD nginx.conf   /etc/nginx/nginx.conf
ADD lancache/    /etc/nginx/lancache
ADD vhosts/      /etc/nginx/vhosts
ADD start-cache  /usr/local/bin/start-cache

# Install BIND9 DNS server
RUN apt-get install -y bind9 bind9utils
ADD dns/*  /etc/bind9/

EXPOSE 80 58
# configure nginx boot
CMD ["start-cache"]
