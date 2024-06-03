#!/bin/bash

#Creating a gvm system user and group
sudo useradd -r -M -U -G sudo -s /usr/sbin/nologin gvm

#Add current user to gvm group
sudo usermod -aG gvm $USER
su $USER

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

./01-gvm-libs.sh
./02-gvmd.sh
./03-pg-gvm.sh
./04-gsa.sh
./05-gsad.sh
./06-openvas-smb.sh
./07-openvas-scanner.sh
./08-ospd-openvas.sh
./09-openvasd.sh
./10-greenbone-feed-sync.sh
./11-gvm-tools.sh