#!/bin/bash

### openvasd
#Setting the openvas versions to use
export OPENVAS_DAEMON=23.0.1

#Required dependencies for openvasd
sudo apt install -y \
  cargo \
  pkg-config \
  libssl-dev
  
#Downloading the openvas-scanner sources
curl -f -L https://github.com/greenbone/openvas-scanner/archive/refs/tags/v$OPENVAS_DAEMON.tar.gz -o $SOURCE_DIR/openvas-scanner-$OPENVAS_DAEMON.tar.gz
curl -f -L https://github.com/greenbone/openvas-scanner/releases/download/v$OPENVAS_DAEMON/openvas-scanner-v$OPENVAS_DAEMON.tar.gz.asc -o $SOURCE_DIR/openvas-scanner-$OPENVAS_DAEMON.tar.gz.asc

tar -C $SOURCE_DIR -xvzf $SOURCE_DIR/openvas-scanner-$OPENVAS_DAEMON.tar.gz

mkdir -p $INSTALL_DIR/openvasd/usr/local/bin
cd $SOURCE_DIR/openvas-scanner-$OPENVAS_DAEMON/rust/openvasd
cargo build --release

cd $SOURCE_DIR/openvas-scanner-$OPENVAS_DAEMON/rust/scannerctl
cargo build --release

sudo cp -v ../target/release/openvasd $INSTALL_DIR/openvasd/usr/local/bin/
sudo cp -v ../target/release/scannerctl $INSTALL_DIR/openvasd/usr/local/bin/
sudo cp -rv $INSTALL_DIR/openvasd/* /