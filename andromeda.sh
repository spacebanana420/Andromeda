#!/bin/bash

#-----Config-----
#encryption=zip (not used yet)
format_zip=andromeda #zip file extension
password=ascii #Password generation type (ascii or dictionary)
password_length=60
dictionary=dictionary.txt
datafolder="" #If not empty, Andromeda will search for databases inside this folder instead of the current directory
#dictionary_separator=space (not used yet)
#----------------

databases(){ #Choose, create and edit databases
echo ""
for i in *
do
    if [[ $i == *".$format_zip"* ]]; then ls $i; datapresent=1; fi
done

if [[ $datapresent == 1 ]]
then
    echo "-------------------------------"
    echo "Choose a database, create a new one or type 'exit'"
else
    echo "Type th name for a new database or type 'exit'"
fi
read database

if [[ $database == "exit" ]]
then
    return;
elif [[ $database == *".$format_zip"* ]]
then
    database=$(basename "$database" ".$format_zip")
fi

echo ""; echo "Input database password or leave blank to autogenerate"
read -s datapass
if [[ $datapass == "" ]]
then
    if [[ -e $dictionary ]]
    then
        datapass=$(lua passgen.lua $luapass $password_length "$dictionary")
    else
        datapass=$(lua passgen.lua 1 $password_length)
        if [[ $luapass == 2 ]]; then echo "Dictionary $dictionary not found. Using ASCII generation instead"; fi
    fi
    echo $datapass > masterkey.txt
    echo "The generated master password for this database has been stored on masterkey.txt, don't forget this password"
fi
if [[ -e ".$database" ]]; then rm -r ".$database"; fi
if [[ -e "$database.$format_zip" ]]
then
    unzip -q -P "$datapass" "$database.$format_zip"
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
echo ""; ls; echo "-----------------------------------"; echo ""; echo "-----Choose an action or leave blank to exit-----"; echo "add  remove  view"
read action
case $action in
add)
    echo ""
    echo "Give a name for this password entry or leave blank to autogenerate"
    read entry
    if [[ -e $entry ]]
    then
        echo "Entry already exists, the password will be changed"
    fi
    echo "Input password"
    read -s password
    if [[ $password == "" ]]
    then
        password=$(lua passgen.lua $luapass $password_length "$dictionary")
    fi
    echo $password > $entry
;;
remove)
    echo "Choose an entry to remove"
    read entry
    echo "Are you sure you want to remove the password entry '$entry'? (y/n)"
    read confirm
    if [[ $confirm == "y" ]]
    then
        rm $entry
    fi
;;
view)
    echo "Show passwords? (y/n)"; read showpass
    for i in *
    do
        if [[ $showpass == "y" ]]
        then
            echo $i ": " $(cat "$i")
        else
            echo $i
        fi
    done
    echo ""
;;
esac
if [[ $action == "add" || $action == "remove" || $action == "view" ]]
then
    readdatabase repeat
else
    cd ..
    mv ".$database" "$database"
    zip -2 -r -q -P "$datapass" "$database.$format_zip" "$database" #Database encryption uses AES on a zip archive for flexibility and global support
    rm -r "$database"
    clear
    databases
fi
}

#Start
echo "Andromeda Password Manager (version 1.1)";

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

if [[ $datafolder != "" && -d $datafolder ]]; then cd "$datafolder"; fi

databases
