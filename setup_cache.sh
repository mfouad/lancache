#!/bin/bash
# use this script to setup the caching system on a VM or baremetal (not running docker)

# update base system
#apt-get update
#apt-get -y dist-upgrade

# install nginx
apt-get install -y software-properties-common
add-apt-repository ppa:nginx/stable
apt-get update
apt-get install -y nginx

# create cache directories
mkdir -p /srv/www/cache/installs
mkdir -p /srv/www/cache/other
mkdir -p /srv/www/cache/tmp

# add nginx configuration
cp nginx.conf   /etc/nginx/nginx.conf
cp lancache/    /etc/nginx/lancache
cp vhosts/      /etc/nginx/vhosts
cp start-cache  /usr/local/bin/start-cache


# Install BIND9 DNS server
DEBIAN_FRONTEND=noninteractive apt-get install -y bind9 bind9utils
cp dns/*  /etc/bind/
chown root:bind /etc/bind/*
service bind restart

# start DNS
#/usr/sbin/named -u bind


: ${CACHE_TYPE:=default}
if [ ! -f /etc/nginx/vhosts/lancache-${CACHE_TYPE}.conf ]; then
	echo "Cannot locate vhost '${CACHE_TYPE}'" >&2
	exit 1
fi

echo " -- Starting ${CACHE_TYPE} cache server -- " >&2

#sed -ri"" "s/include vhosts[^;]*;/include vhosts\/lancache-${CACHE_TYPE}.conf;/" /etc/nginx/nginx.conf

# start Cache server
nginx &

#$IP = /sbin/ifconfig -a | grep -A 8 eth0 | grep inet | head -1 | awk '{print $2}'
