#!/bin/bash

#----- config
. deployment.config

arr=("main*.js" "scripts.*js" "1.*.js" "2.*.js" "3.*.js" "4.*.js" "5.*.js" "6.*.js" "7.*.js" "8.*.js" "9.*.js" "10.*.js")

ENV=$1select

GSPATH=gs://$ENV.airasia.com/booking

cd $DIST_PATH;

echo "$(tput setaf 2) Uploading started....";

for i in "${arr[@]}"
do

    #echo "Uploading" $i
    gsutil -h "Content-Encoding:gzip" -h "Content-Type:application/javascript" -h "Cache-Control:max-age=0,no-cache" cp $i $GSPATH
done

gsutil -h "Content-Encoding:gzip" -h "Content-Type:text/css" -h "Cache-Control:max-age=0,no-cache" cp styles*css $GSPATH

gsutil -h "Content-Type:application/javascript" -h "Cache-Control:max-age=0,no-cache" cp common*js $GSPATH

gsutil -h "Content-Type:application/javascript" -h "Cache-Control:max-age=0,no-cache" cp runtime*js $GSPATH

gsutil -h "Content-Type:application/javascript" -h "Cache-Control:max-age=0,no-cache" cp safe*js $GSPATH

gsutil -h "Content-Type:application/javascript" -h "Cache-Control:max-age=0,no-cache" cp worker*js $GSPATH

gsutil -h "Content-Type:text/html" -h "Cache-Control:max-age=0,no-cache" cp index.html $GSPATH

gsutil -h "Content-Type:image/x-icon" -h "Cache-Control:max-age=0,no-cache" cp favicon.ico $GSPATH

gsutil -h "Content-Type:text/plain" -h "Cache-Control:max-age=0,no-cache" cp 3rd*txt $GSPATH

gsutil -h "Content-Type:application/javascript" -h "Cache-Control:max-age=0,no-cache" cp ng*js $GSPATH

gsutil -h "Content-Type:application/octet-stream" -h "Cache-Control:max-age=0,no-cache" cp ng*json $GSPATH

gsutil -h "Content-Type:application/octet-stream" -h "Cache-Control:max-age=0,no-cache" cp manifest*json $GSPATH

gsutil -h "Content-Type:application/json" -h "Cache-Control:max-age=0,no-cache" cp app/_resources/*.json $GSPATH/app/_resources

gsutil -h "Content-Type:application/json" -h "Cache-Control:max-age=0,no-cache" cp app/_resources/Configurations.json $GSPATH/app/_resources

gsutil cp -r assets $GSPATH

#move to current file location
cd $SH_PATH_DIST

echo "Uploading done!!! $(tput setaf 7)"