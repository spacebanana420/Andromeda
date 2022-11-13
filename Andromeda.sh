#!/bin/bash

#-----Config-----
file=zip
password=dictionary
password_length=60
dictionary=dictionary.txt
dictionary_separator=space
#----------------

echo "Andromeda Password Manager (version 0.5 dev build 2)"; echo ""

if [[ $password == "ascii" ]]
then
    luapass=1
else
    luapass=2
fi

databases(){ #Choose, create and edit databases
if [[ -e databases.txt  && -e *$(cat databases.txt)* ]]
then
    ls *$(cat databases.txt)*; echo ""
    echo "Choose a database or create a new one"
    read database
    echo "Input database password"
    read datapass
    if [[ $database == *$(cat databases.txt)* ]]
    then
        unzip -P "$datapass" $database.zip
    else
        echo $database >> databases.txt
        mkdir "$database"
    fi
else
    echo "No databases found. Give a name for the new database or leave blank for 'database0'"
    read database
    if [[ $database == "" ]]
    then
        database="database0"
    fi
    echo "Give a password for the database or leave blank for autogeneration"
    read datapass
    if [[ $datapass == "" ]]
    then
        datapass=$(lua passgen.lua $luapass $password_length $dictionary)
        echo "A password has been generated for your database:"; echo "$datapass"
    fi
    echo $database > databases.txt
    mkdir $database
fi
mv "$database" ".$database"
cd ".$database"
readdatabase
}

readdatabase() { #Manage the stored passwords in the database
ls; echo ""; echo "Choose an action"; echo "add  remove  view"
read action
case $action in
add)
    echo "Give a name for this password entry"
    read entry
    if [[ -e $entry ]]
    then
        echo "Entry already exists, the password will be changed"
    fi
    echo "Input password"
    read password; echo $password > $entry
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
;;
esac
cd ..
mv ".$database" "$database"
zip -3 -r -q -P "$datapass" "$database.zip" "$database" #Database encryption uses AES on a zip archive for flexibility and global support
rm -r "$database"
databases
}

case $1 in
repair)
    datacheck=$(cat databases.txt)
    for i in *
    do
        if [[ $i == *".zip"* || $datacheck != *"$i"*  ]]
        then
            echo $i >> databases.txt
        fi
    done
    echo "Database information has been fixed"
;;
*)
    databases #Default script execution
;;
esac
