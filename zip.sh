#!/bin/bash

#param 1 = env pp/stg
#param 2 = build = 20180830

#DIST_PATH=../../booking-app/dist
#SH_PATH=../../AirAsia-Select/deployment_mac

#----- config
. deployment.config

ENV=$1select

ZIP_FILENAME=$2_$1

GSPATH=gs://$ENV.airasia.com/booking

cd $DIST_PATH;

echo "$(tput setaf 3) Zip Started.....";

zip -r -X -9 ${ZIP_FILENAME}.zip *


while true; do
    read -p "Do you want to upload this? Y/n" yn
    case $yn in
        [Yy]* ) gsutil -h "Content-Type:application/octet-stream" -h "Cache-Control:max-age=0,no-cache" cp ${ZIP_FILENAME}.zip $GSPATH/_pkg; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


#move to current file location
cd $SH_PATH_DIST

echo "Zip Done!!! $(tput setaf 7)"