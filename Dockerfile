
FROM proxy:0.1
MAINTAINER mfouad

# create cache directories
RUN mkdir -p /srv/www/cache/installs && \
    mkdir -p /srv/www/cache/other && \
    mkdir -p /srv/www/cache/tmp

# add nginx configuration
ADD nginx.conf   /etc/nginx/nginx.conf
ADD lancache/    /etc/nginx/lancache
ADD vhosts/      /etc/nginx/vhosts
ADD start-cache  /usr/local/bin/start-cache

ADD dns/*  /etc/bind/
RUN chown root:bind /etc/bind/*

EXPOSE 80 53/udp
# configure nginx boot
CMD ["start-cache"]
