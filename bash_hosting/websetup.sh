#!/bin/bash

#VARIABLES 
PACKAGES="apache2 unzip wget"
SVC="apache2"
TMP_DIR="/tmp/webfiles"
WEB_URL="https://www.tooplate.com/zip-templates/2098_health.zip"
ART_NAME="2098_health"

# Installing Dependencies
echo "########################################"
echo "Installing packages."
echo "########################################"
sudo apt update
sudo apt install $PACKAGES -y >> /dev/null
echo

# Start & Enable Service
echo "########################################"
echo "Start & Enable APACHE2 Service"
echo "########################################"
sudo systemctl start $SVC
sudo systemctl enable $SVC
echo

# Creating Temp Directory
echo "########################################"
echo "Starting Artifact Deployment"
echo "########################################"
mkdir -p $TMP_DIR
cd $TMP_DIR
echo

wget $WEB_URL > /dev/null
unzip $ART_NAME.zip > /dev/null
sudo cp -r $ART_NAME/* /var/www/html/
echo

# Bounce Service
echo "########################################"
echo "Restarting APACHE2 service"
echo "########################################"
systemctl restart $SVC
echo

# Clean Up
echo "########################################"
echo "Removing Temporary Files"
echo "########################################"
rm -rf /tmp/webfiles

sudo systemctl status $SVC
ls /var/www/html/

