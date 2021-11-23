#!/bin/bash

# Read configuration variables
read -p "What is the path to your shell config file? " PROFILE
read -p "What is your gmail address? " GMAIL
read -p "What is your gmail username? " GUSER
read -p "What is your gmail password? " GPASS

PWD=`pwd`
# Store configuration variables
echo -e "\nexport PATH=${PWD}:\${PATH}\nexport TODO_LIST_PATH=${PWD}\nexport GUSER=${GUSER}\nalias todo='${PWD}/todo'\n. ${PWD}/todo_loader.sh" >> ${PROFILE}

# Add postfix configurations
sudo cat "postfix_config.txt" >> /etc/postfix/main.cf

# Add sasl password
sudo mkdir "/etc/postfix/sasl"
sudo echo "[smtp.gmail.com]:587 ${GUSER}@gmail.com:${GPASS}" > /etc/postfix/sasl/sasl_passwd

# Setup address mapping
sudo echo "user@host.domain ${GMAIL}" >> /etc/postfix/generic
sudo echo "@host.domain     ${GMAIL}" >> /etc/postfix/generic

# Protect credentials and restart Postfix
sudo chmod -R 600 /etc/postfix/sasl
sudo postmap /etc/postfix/sasl/sasl_passwd
sudo postmap /etc/postfix/generic
sudo launchctl stop org.postfix.master
sudo launchctl start org.postfix.master
