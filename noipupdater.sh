#!/usr/bin/env bash

# No-IP can use emails as usernames; in that case make sure that you encode the @ as %40
USERNAME=username
PASSWORD=password
HOSTS=(hostsite1 hostsite2 hostsite3) # List of your hosts i.e. HOSTS=(xyz.redirectme.net yzx.redirectme.net zyx.redirectme.net)

USERAGENT="Simple Bash No-IP Updater"
LOGFILE=noip.log
NEWIP=$(wget -O - http://icanhazip.com/ -o /dev/null)


STOREDIPFILE=storedip
if [ ! -e $STOREDIPFILE ]; then
    touch $STOREDIPFILE
fi
STOREDIP=$(cat $STOREDIPFILE)

for HOST in ${HOSTS[@]}; do
    if [ "$NEWIP" != "$STOREDIP" ]; then
        RESULT=$(wget -O- -q --user-agent="$USERAGENT" --no-check-certificate "https://$USERNAME:$PASSWORD@dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$NEWIP")

        LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] $HOST: $RESULT"
        echo $NEWIP > $STOREDIPFILE
    else
        LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] $HOST: No IP change"
    fi

    echo $LOGLINE >> $LOGFILE
done

exit 0


