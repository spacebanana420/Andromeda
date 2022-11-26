Andromeda
====
The Andromeda Password Manager is a CLI password manager utility made for Linux and BSD-based systems

Andromeda uses symmetric AES encryption for its databases, stored in zip archives for flexibility. This utility is meant for a lighter and less serious use, it does not replace the complexity and security of commonly used password managers, although newer versions are starting to become secure and reliable enough for serious use

Besides password management, a Lua script is also included and integrated with the main shell script to generate passwords based on either the ASCII table or a keyword dictionary

Features
--------
write features here lolololollololololol

Downloads
---------

Grab the stable releases [here](https://github.com/spacebanana420/Andromeda/releases). But you can also get the developpement build from the repository.

How to use
----------
Download andromeda.sh and (optionally) passgen.lua and execute andromeda.sh with bash

The configuration is located inside the main script

**Note:** You should always download from the releases, as they are stable versions. Downloading from the repo source will most likely give you dev/testing versions which might have bugs and unstable/unfinished code.

Requirements
----------
This project was written with Linux/FreeBSD in mind, however it might still work on other OSes with help of some external tools.

(In the future I will test Andromeda for Alpine Linux and FreeBSD. If you are able to test Andromeda on MacOS or BSD-based systems, please contact me at tomasbessa@protonmail.com
)

Libraries Requirements
----------------------
* Bash
* Lua (only tested with 5.4!)
* zip/unzip
* GNU Core Utilities / Busybox

License
-------
This project uses the [MIT](./license.md) license.

Copyright
---------
Space Banana - Tomas Bessa whatever write it yourself lmao