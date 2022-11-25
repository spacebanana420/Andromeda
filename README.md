## Introduction
The Andromeda Password Manager is a CLI password manager utility made for Linux and BSD-based systems

Andromeda uses symmetric AES encryption for its databases, stored in zip archives for flexibility. This utility is meant for a lighter and less serious use, it does not replace the complexity and security of commonly used password managers, although newer versions are starting to become secure and reliable enough for serious use

Besides password management, a Lua script is also included and integrated with the main shell script to generate passwords based on either the ASCII table or a keyword dictionary

## How to use
Download andromeda.sh and (optionally) passgen.lua and execute andromeda.sh with bash

The configuration is located inside the main script

**Note:** You should always download from the releases, as they are stable versions. Downloading from the repo source will most likely give you dev/testing versions which might have bugs and unstable/unfinished code.
## Requirements
Bash, Lua (5.4 recommended), zip and unzip, GNU coreutils or Busybox
