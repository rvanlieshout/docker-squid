#!/bin/bash

if [ -n "${CACHE_PEER}" ]; then
  url=$CACHE_PEER

	# extract the user and password (if any)
	userpass="`echo $url | grep @ | cut -d@ -f1`"
	pass=`echo $userpass | grep : | cut -d: -f2`
	if [ -n "$pass" ]; then
		user=`echo $userpass | grep : | cut -d: -f1`
	else
		user=$userpass
	fi

	# extract the host -- updated
	hostport=`echo $url | sed -e s,$userpass@,,g | cut -d/ -f1`
	port=`echo $hostport | grep : | cut -d: -f2`
	if [ -n "$port" ]; then
		host=`echo $hostport | grep : | cut -d: -f1`
	else
		host=$hostport
	fi
	echo "cache_peer $host parent $port 0 no-query default login=$userpass" >> /etc/squid/squid.conf
	echo "never_direct allow all" >> /etc/squid/squid.conf
fi

# -X verbose debug logging
# -N Don't run in daemon mode - important for docker
squid -N -X



