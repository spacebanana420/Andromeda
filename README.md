Andromeda
====
The Andromeda Password Manager is a CLI password manager utility made for Linux and BSD-based systems

Andromeda uses symmetric AES encryption for its databases, stored in zip archives for flexibility.

Besides password management, a Lua script is also included and integrated with the main shell script to generate passwords based on either the ASCII table or a keyword dictionary

This program is still very fresh. You might encounter bugs and notice the lack of special features, although the amount of bugs has been severely reduced 

Features
--------
* Password and database management

* AES encryption for databases

* zip deflate compression

* Muliple database support

* Multiple password entries per database

* Custom database file extension

* ASCII and dictionary-based password generation with custom length

Downloads
---------
Grab the stable releases [here](https://github.com/spacebanana420/Andromeda/releases)

But you can also get the testing build from the repository.

How to use
----------
Download andromeda.sh and (optionally) passgen.lua and execute andromeda.sh with bash

The configuration is located inside the main script

**Note:** You should always download from the releases, as they are stable versions. Downloading from the repo source will most likely give you dev/testing versions which might have bugs and unstable/unfinished code.

Supported systems
----------
This project was written with Linux in mind, however it will work on any system as long as you can get the required dependencies. For basic utilities like "ls", "basename" or "cp", the script requires the GNU coreutils, busybox utils or the "BSD coreutils" seen in FreeBSD or similar.

Officially supported systems:
* Debian Linux and derivatives (Ubuntu, Mint, etc)
* Arch Linux and derivatives (EndeavourOS, Manjaro, etc)
* Fedora Linux
* Void Linux
* Alpine Linux
* FreeBSD

*If you are able to test Andromeda on MacOS or other BSD-based systems besides FreeBSD, please contact me at tomasbessa@protonmail.com*

Requirements
----------------------
* Bash
* Lua (only tested with 5.4)
* zip and unzip

#### Installing dependencies
Debian: ``` apt install lua5.4 zip unzip ```

Arch Linux: ``` pacman -S lua zip unzip ```

Fedora: ``` dnf install lua zip unzip ```

Void: ``` xbps-install lua54 zip unzip ```

Alpine Linux: ``` apk add lua5.4 zip unzip bash ```

FreeBSD: ``` pkg install lua54 zip unzip bash ```

*Bash comes preinstalled on most Linux systems*

License
-------
This project uses the [MIT](./license.md) license.
