#!/bin/bash

### pg-gvm
export PG_GVM_VERSION=22.6.4

#Required dependencies for pg-gvm
sudo apt install -y \
  libglib2.0-dev \
  postgresql-server-dev-14 \
  libical-dev
  
#Downloading the pg-gvm sources
curl -f -L https://github.com/greenbone/pg-gvm/archive/refs/tags/v$PG_GVM_VERSION.tar.gz -o $SOURCE_DIR/pg-gvm-$PG_GVM_VERSION.tar.gz
curl -f -L https://github.com/greenbone/pg-gvm/releases/download/v$PG_GVM_VERSION/pg-gvm-$PG_GVM_VERSION.tar.gz.asc -o $SOURCE_DIR/pg-gvm-$PG_GVM_VERSION.tar.gz.asc

tar -C $SOURCE_DIR -xvzf $SOURCE_DIR/pg-gvm-$PG_GVM_VERSION.tar.gz

#Building pg-gvm
mkdir -p $BUILD_DIR/pg-gvm && cd $BUILD_DIR/pg-gvm

cmake $SOURCE_DIR/pg-gvm-$PG_GVM_VERSION \
  -DCMAKE_BUILD_TYPE=Release

make -j$(nproc)

#Installing pg-gvm
mkdir -p $INSTALL_DIR/pg-gvm

make DESTDIR=$INSTALL_DIR/pg-gvm install

sudo cp -rv $INSTALL_DIR/pg-gvm/* /