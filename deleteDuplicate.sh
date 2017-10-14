#!/bin/sh
# This script is written by whm

tempDirectory="/volume1/@download/"

checkAndDelete() {
   local cur_dir flag
   cur_dir=$1
   for filelist in $(ls ${cur_dir}| grep -v ".torrent" | grep -v ".resume"|tr " "  "?")
   do
    echo ${filelist}
    flag=$(find "${filelist}" -name *.part | wc -l)
    if [[ $flag -eq 0 ]]; then
        rm -rf "$filelist"
    fi
   done
}
scandir() {
    local cur_dir parent_dir workdir
    workdir=$1
    cd ${workdir}
    if [ ${workdir} = "/" ]
    then
        cur_dir=""
    else
        cur_dir=$(pwd)
    fi
 
    for dirlist in $(ls ${cur_dir} | grep "^[0-9]*$")
    do
        if test -d ${dirlist};then
            cd ${dirlist}
            checkAndDelete ${cur_dir}/${dirlist}
            cd ..
        fi
    done
}


if test -d $tempDirectory
then
    scandir $tempDirectory
elif test -f $tempDirectory
then
    echo "you input a file but not a directory,pls reinput and try again"
    exit 1
else
    echo "the Directory isn't exist which you input,pls input a new one!!"
    exit 1
fi