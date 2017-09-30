#!/usr/bin/env bash

# Mandatory fields
USERNAME=username # No-IP uses emails as usernames, so make sure that you encode the @ as %40
PASSWORD=password
HOSTS=(hostsite1 hostsite2 hostsite3) # List of your hosts i.e. HOSTS=(xyz.redirectme.net yzx.redirectme.net zyx.redirectme.net)

# Optrional
IPQUERYHOST="http://icanhazip.com"
USERAGENT="Simple Bash No-IP Updater"
LOGFILE=noip.log
NEWIP=$(curl --silent $IPQUERYHOST)

STOREDIPDIR=storedips
if [ ! -d $STOREDIPDIR ]; then
    mkdir $STOREDIPDIR
fi

for HOST in ${HOSTS[@]}; do
    STOREDIPFILE="${STOREDIPDIR}/${HOST}.ip"

    if [ ! -e $STOREDIPFILE ]; then
        touch $STOREDIPFILE
    fi
    
    STOREDIP=$(cat $STOREDIPFILE)

    if [ "$NEWIP" != "$STOREDIP" ]; then
        RESULT=$(curl --silent --user-agent $USERAGENT --insecure "https://$USERNAME:$PASSWORD@dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$NEWIP")
        
        echo $NEWIP > $STOREDIPFILE
        LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] $HOST: $RESULT"
    else
        LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] $HOST: No IP change"
    fi
    
    echo $LOGLINE >> $LOGFILE
done

exit 0
