#!/bin/bash

validate_argument()
{
    if ! [ -z "$1" ];
    then
        echo "Archiving your logs......"
    else
        echo "Please enter the first argument, usage: ./log-archive.sh <directory>"
        exit 1
    fi
}

archive_log()
{
    dir_name=$(basename "$1")
    x=$(date +"%Y%m%d_%H%M%S")
    filename="${dir_name}_${x}.tar.gz"
    tar -czvf "/var/log/$filename" "$1"
}

###################### MAIN ###############################
validate_argument "$1"  
archive_log "$1"