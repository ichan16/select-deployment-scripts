#!/bin/bash

#reference - https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux

#----- config
. deployment.config

cd $DEV_PATH;

DATE=`date '+%Y%m%d_%H%M'`

if [ "$1" == "pp" ] 
then
    ng build --configuration=pp --prod --base-href=/booking/
elif [ "$1" = "stg" ]
then
    ng build --configuration=sit --prod --base-href=/booking/
elif [ "$1" = "prod" ]
then
	ng build --configuration=prod --prod --base-href=/booking/
    #ng build --configuration=prod --prod --base-href=/booking/
fi

#----- move to current file location
cd $SH_PATH;


#----- ask deployment if preprod or staging
if [ "$1" == "pp" ] || [ "$1" == "stg" ]
then 
	## ask question to deploy it after finishing build
	while true; do
	    read -p "Build done... Do you want to deploy this build? Y/n" yn
	    case $yn in
	        [Yy]* ) sh deploy.sh $1; break;;
	        [Nn]* ) exit;;

	        * ) echo "Please answer yes or no.";;
	    esac
	done
fi


if [ "$1" == "prod" ]
then 
	## ask question to deploy it after finishing build
	while true; do
	    read -p "Build done... Do you want to zip this build? Y/n" yn
	    case $yn in
	        [Yy]* ) sh zip.sh $1 $DATE; break;;
	        [Nn]* ) exit;;
	        * ) echo "Please answer yes or no.";;
	    esac
	done
fi


