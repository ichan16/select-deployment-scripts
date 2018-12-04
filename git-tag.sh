#!/bin/bash

. deployment.config

cd $DEV_PATH;

echo "$(tput setaf 6) Creating tags....";

git tag $1

echo "Pushing tags....";

git push --tags

SH_PATH=../AirAsia-Select/deployment_mac

#move to current file location
cd $SH_PATH;

echo "Tags created!! $(tput setaf 7)";
