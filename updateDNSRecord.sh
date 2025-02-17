#!/bin/bash

IPADDRESS=$(ifconfig | grep "inet 10" | awk '{ print $2 }')
HOSTNAME=`hostname`

if [ "$IPADDRESS" != "" ]; then
	echo "update delete $HOSTNAME.highmark.com A" > $TMPDIR/nsupdate
	echo "update add $HOSTNAME.highmark.com 86400 A $IPADDRESS" >> $TMPDIR/nsupdate
	echo "send" >> $TMPDIR/nsupdate
	nsupdate $TMPDIR/nsupdate
fi