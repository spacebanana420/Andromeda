#!/bin/bash

#-----Config-----
#encryption=zip (not used yet)
format_zip=andromeda #zip file extension
password=dictionary #Password generation type (ascii or dictionary)
password_length=60
dictionary=dictionary.txt
dictionary_separator=space
#----------------

databases(){ #Choose, create and edit databases
echo ""; ls *".$format_zip"*;
echo "-----------------------------------";
echo "Choose a database or create a new one"
read database
echo "Input database password"
read -s datapass
if [[ -e *"$database.$format_zip"* ]]
then
    unzip -P "$datapass" "$database.$format_zip"
else
    mkdir "$database"
fi

if [[ $(id -u) == "0" ]]
then
    chmod u=rw,g=rw,o= "$database"
    chown root:root "$database"
fi

mv "$database" ".$database"
cd ".$database"
readdatabase
}

readdatabase() { #Manage the stored passwords in the database
ls; echo ""; echo "-----Choose an action or leave blank to exit-----"; echo "add  remove  view"
read action
case $action in
add)
    echo ""
    echo "Give a name for this password entry"
    read entry
    if [[ -e $entry ]]
    then
        echo "Entry already exists, the password will be changed"
    fi
    echo "Input password"
    read -s password; echo $password > $entry
;;
remove)
    echo "Choose an entry to remove"
    read entry
;;
view)
    for i in *
    do
        echo $i ": " $(cat $i)
    done
    echo ""
;;
esac
if [[ $action == "add" || $action == "remove" || $action == "view" ]]
then
    readdatabase
else
    cd ..
    mv ".$database" "$database"
    zip -3 -r -q -P "$datapass" "$database.$format_zip" "$database" #Database encryption uses AES on a zip archive for flexibility and global support
    rm -r "$database"
    databases
fi
}

#Start
echo "Andromeda Password Manager (version 1.0)";

if [[ $password == "ascii" ]]
then
    luapass=1
else
    luapass=2
fi

if [[ $(id -u) != "0" ]]
then
    echo "For the safety of database extraction you should run this script as root"
fi
databases
