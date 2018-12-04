#!/bin/bash
. deployment.config

arr=("main*.js" "scripts.*js" "1.*.js" "2.*.js" "3.*.js" "4.*.js" "5.*.js" "6.*.js" "7.*.js" "8.*.js" "9.*.js" "10.*.js" "styles*.css")

GZEXT=gz
JSEXT=js

cd $DIST_PATH;

# _main=(main*.js)
# gzip $_main
# _mainGz=("$_main".$GZEXT)
# mv "$_mainGz" "${_mainGz%.*}"

echo "$(tput setaf 6) Gzipping start";


for i in "${arr[@]}"
do
    echo "Processing" $i
    gzip $i
    _matchFileNameTemp="$i".$GZEXT
    _matchFileNameToReplace=($_matchFileNameTemp)
    mv "$_matchFileNameToReplace" "${_matchFileNameToReplace%.*}"
done

#move to current file location
cd $SH_PATH

echo "Gzipping done $(tput setaf 7)";