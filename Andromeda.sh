#!/bin/bash

echo "Andromeda Password Manager (version 0.4 dev build 4)"; echo ""
if [[ -e config.txt ]]
then
    if [[ $(cat config.txt) != *"version=0.4"* ]]
    then
        echo "Warning: config file might not be supported by this version"
    fi
else
    echo "version=0.4" > config.txt; echo "file=zip" >> config.txt; echo "password=dictionary" >> config.txt; echo "ascii_char_length=60" >> config.txt; echo "dictionary_char_length=60" >> config.txt; echo "default_dictionary=true" >> config.txt; echo "dictionary_separator=space" >> config.txt;
fi

#Config read
if [[ $(cat config.txt) == *"password=ascii"* ]]
then
    luapass=1
else
    luapass=2
fi
if [[ $(cat config.txt) == *"default_dictionary=true"* ]]
then
    defdictionary=dictionary.txt
fi
#End of config read

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
        datapass=$(lua passgen.lua $luapass 60 $defdictionary)
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
