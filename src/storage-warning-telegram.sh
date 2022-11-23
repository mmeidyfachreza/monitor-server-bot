#!/bin/bash
DISK=$(df / | grep '/')
NAME=$(echo $DISK | awk '{print $1}')
CURRENT=$(echo $DISK | awk '{print $5}' | sed 's/%//g')
THRESHOLD=thres
IPADDR=$(hostname -I | awk '{print $1}')

if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
    . /etc/telegram/telegram-notify --error --title "Storage Warning For Server1! IP $IPADDR" --text "Your $NAME partition available space is critically low. Used: $CURRENT%"
fi
