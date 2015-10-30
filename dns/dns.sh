#!/bin/sh
# add new Content servers and Download servers to the DOMAINS list below,
# this script will populate the DNS server's Zones records with these servers.
# the script will run automatically during the build process. (or docker build if you are using docker)

DNSS="steam"
DOMAINS=""

# comment this if you dont cache steam
DOMAINS="$DOMAINS cs.steampowered.com content1.steampowered.com content2.steampowered.com content3.steampowered.com content4.steampowered.com content5.steampowered.com content6.steampowered.com content7.steampowered.com content8.steampowered.com content9.steampowered.com hsar.steampowered.com.edgesuite.net akamai.steamstatic.com content-origin.steampowered.com client-download.steampowered.com"
# comment this if you dont cache ubuntu
# DOMAINS="$DOMAINS fr.archive.ubuntu.com security.ubuntu.com"

for dns in $DNSS; do
    out=named.conf.$dns
    echo "// build by ${0}" > $out
    echo "// re-run it commenting relevant domains if you dont cache them all" > $out
    for domain in $DOMAINS; do
	     echo zone \"$domain\"  \{ type master\; notify no\; file \"/etc/bind/db.$dns\"\; \}\; >> $out
    done
    echo "// EOF" >> $out
done
