#!/bin/bash
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi
TELEGRAM_DIR=/etc/telegram
SCRIPTS_DIR=/home/scripts
echo "check telegram directory exists...."
if [ -d "$TELEGRAM_DIR" ];
then
        echo "$TELEGRAM_DIR directory exists."
	exit 0
else
        echo "$TELEGRAM_DIR directory does not exist. try to mkdir"
        sudo mkdir /etc/telegram
        sudo mkdir /etc/telegram/conf
	echo "check scripts directory exist...."
	if [ -d "$SCRIPTS_DIR" ];
	then
        	echo "$SCRIPTS_DIR directory exists."
		exit 0
	else
        	echo "$SCRIPTS_DIR directory does not exist. try to mkdir"
        	sudo mkdir /home/scripts
	fi
fi

sudo cp src/telegram-notify $TELEGRAM_DIR
sudo cp src/telegram-notify.conf $TELEGRAM_DIR/conf
sudo cp src/storage-warning-telegram.sh $SCRIPTS_DIR

read -p "do you want to configuration telegram bot now? Enter [y/n] : " opt
if [ $opt == "y" ]
then
    read -p "your bot api key: " YourAPIKey
    read -p "Your User ID or Channel ID: " YourUserOrChannelID
    sudo sed -n 's/YourAPIKey/$YourAPIKey/g' $TELEGRAM_DIR/conf/telegram-notify.conf
    sudo sed -n 's/YourUserOrChannelID/$YourUserOrChannelID/g' $TELEGRAM_DIR/conf/telegram-notify.conf
fi

read -p "do you want to configuration disk threshold now? Enter [y/n] : " opt
if [ $opt == "y" ]
then
    read -p "disk threshold %: " THRESHOLD
    sudo sed -n 's/thres/$THRESHOLD/g' $SCRIPTS_DIR/storage-warning-telegram.sh
fi

echo "instalation complete"
