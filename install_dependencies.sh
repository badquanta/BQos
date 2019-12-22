#!/usr/bin/env bash
set DEB_PACKAGES= \
    build-essential\
    bison\
    flex\
    libgmp3-dev\
    libmpc-dev\
    texinfo\
    libcloog-isl-dev\
    libisl-dev

sudo apt-get update 
sudo apt install -y $DEB_PACKAGES
sudo apt upgrade -y $DEB_PACKAGES