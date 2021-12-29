#!/bin/bash

BASEPATH="/usr/local/samba"

if [ -z "$1" ] || [ -z "$2" ]
  then
    echo "No argument supplied"
    echo "set_user <username> <group>"
    exit 0
fi
useradd $1
groupadd $2
usermod -aG $2 $1
$BASEPATH/bin/smbpasswd -a $1
$BASEPATH/bin/smbcontrol smbd reload-config

