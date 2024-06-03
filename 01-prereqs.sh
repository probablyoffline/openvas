#!/bin/bash


#Setting an install prefix environment variable
export INSTALL_PREFIX=/usr/local

#Adjusting PATH for running gvmd
export PATH=$PATH:$INSTALL_PREFIX/sbin

#Choosing a source directory
export SOURCE_DIR=$HOME/source
mkdir -p $SOURCE_DIR

#Choosing a build directory
export BUILD_DIR=$HOME/build
mkdir -p $BUILD_DIR

#Choosing a temporary install directory
export INSTALL_DIR=$HOME/install
mkdir -p $INSTALL_DIR

#Installing Common Build Dependencies
sudo apt update
sudo apt install --no-install-recommends --assume-yes \
  build-essential \
  curl \
  cmake \
  pkg-config \
  python3 \
  python3-pip \
  gnupg
  
curl -f -L https://www.greenbone.net/GBCommunitySigningKey.asc -o /tmp/GBCommunitySigningKey.asc
gpg --import /tmp/GBCommunitySigningKey.asc

echo "8AE4BE429B60A59B311C2E739823FAA60ED1E580:6:" | gpg --import-ownertrust

./02-gvm-libs.sh
./03-gvmd.sh
./04-pg-gvm.sh
./05-gsa.sh
./06-gsad.sh
./07-openvas-smb.sh
./08-openvas-scanner.sh
./09-ospd-openvas.sh
./10-openvasd.sh
./11-greenbone-feed-sync.sh
./12-gvm-tools.sh
./13-redis.sh
./14-permissions.sh
./15-feed.sh