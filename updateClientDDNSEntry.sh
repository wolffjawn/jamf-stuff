#!/bin/sh

# FUNCTIONS

# Submits a Dynamic DNS Update Request to the Highmark name server.
submitDDNSUpdateRequestToNameServer() {
	IP_ADDRESS=$(ifconfig | grep "inet 10" | awk '{ print $2 }')
	HOSTNAME=`hostname`
	
	if [ "$IP_ADDRESS" != "" ]; then
		echo "update delete $HOSTNAME.highmark.com A" > $TMPDIR/nsupdate
		echo "update add $HOSTNAME.highmark.com 86400 A $IP_ADDRESS" >> $TMPDIR/nsupdate
		echo "send" >> $TMPDIR/nsupdate
		nsupdate $TMPDIR/nsupdate
	else
		echo "Request not submitted due to missing IP address."
	fi
}

# SCRIPT

# Ping a public IP address to check for an active network connection
ping -c 1 8.8.8.8 > /dev/null

# If the ping command is successful, then the network connection is active
if [[ $? -eq 0 ]]; then
	submitDDNSUpdateRequestToNameServer 
else
	echo "No active Internet connection."
fi
