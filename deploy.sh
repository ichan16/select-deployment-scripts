#!/bin/bash

#reference - https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux

#param = env pp/stg

ENV="$1select"

#deployment build date
DATE=`date '+%Y%m%d_%H%M'`

echo "$(tput setaf 1) Deployment Started..... $(tput setaf 7)"

#gzip the build files
sh gzip.sh

# deploy the build files on google cloud
sh upload.sh $1

#zip the build files then upload to google cloud
sh zip.sh $1 $DATE

echo "$(tput setaf 1) Deployment Done....."

BUILD="$DATE"_"$1"

echo "$(tput setaf 5) Deploy build: $BUILD $(tput setaf 7)"

## ask question to create tags it after finishing deploy
while true; do
    read -p "Do you want to create tags? Y/n" yn
    case $yn in
        [Yy]* ) sh git-tag.sh $BUILD; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done