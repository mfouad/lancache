#!/bin/bash
# use this script to setup the caching system on a VM or baremetal (not running docker)

# create cache directories
mkdir -p /srv/www/cache/installs
mkdir -p /srv/www/cache/other
mkdir -p /srv/www/cache/tmp

# add nginx configuration
cp nginx.conf   /etc/nginx/nginx.conf
cp -r lancache    /etc/nginx/
cp -r vhosts      /etc/nginx/
cp start-cache  /usr/local/bin/start-cache

# Install BIND9 DNS server
cp dns/*  /etc/bind/
chown root:bind /etc/bind/*

# start DNS
#/usr/sbin/named -u bind

# start Cache server
service bind9 restart
service nginx restart


#$IP = /sbin/ifconfig -a | grep -A 8 eth0 | grep inet | head -1 | awk '{print $2}'
