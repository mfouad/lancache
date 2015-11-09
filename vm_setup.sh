#!/bin/bash
# use this script to setup the caching system on a VM or baremetal (not running docker)

# update base system
apt-get update
apt-get -y dist-upgrade

# install nginx
apt-get install -y software-properties-common
add-apt-repository ppa:nginx/stable
apt-get update
apt-get install -y nginx

ufw enable
ufw allow domain
ufw allow http
ufw allow https
ufw allow ssh
ufw status

# Install BIND9 DNS server
DEBIAN_FRONTEND=noninteractive apt-get install -y bind9 bind9utils
