#!/bin/bash

# Read configuration variables
read -p "What is the path to your shell config file? " PROFILE
read -p "What is your gmail address? " GMAIL
read -p "What is your gmail username? " GUSER
read -p "What is your gmail password? " GPASS

PWD=`pwd`
# Store configuration variables
echo -e "\nexport TODO_LIST_PATH=${PWD}\nexport GMAIL=${GMAIL}\nexport GUSER=${GUSER}\nexport GPASS=${GPASS}\n. ${PWD}/todo_loader.sh" >> ${PROFILE}

