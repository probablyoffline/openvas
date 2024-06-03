#!/bin/bash

### openvas-scanner
export OPENVAS_SCANNER_VERSION=23.0.1

#Required dependencies for openvas-scanner
sudo apt install -y \
  bison \
  libglib2.0-dev \
  libgnutls28-dev \
  libgcrypt20-dev \
  libpcap-dev \
  libgpgme-dev \
  libksba-dev \
  rsync \
  nmap \
  libjson-glib-dev \
  libcurl4-gnutls-dev \
  libbsd-dev
  
#Debian optional dependencies for openvas-scanner
sudo apt install -y \
  python3-impacket \
  libsnmp-dev
  
#Downloading the openvas-scanner sources
curl -f -L https://github.com/greenbone/openvas-scanner/archive/refs/tags/v$OPENVAS_SCANNER_VERSION.tar.gz -o $SOURCE_DIR/openvas-scanner-$OPENVAS_SCANNER_VERSION.tar.gz
curl -f -L https://github.com/greenbone/openvas-scanner/releases/download/v$OPENVAS_SCANNER_VERSION/openvas-scanner-v$OPENVAS_SCANNER_VERSION.tar.gz.asc -o $SOURCE_DIR/openvas-scanner-$OPENVAS_SCANNER_VERSION.tar.gz.asc

tar -C $SOURCE_DIR -xvzf $SOURCE_DIR/openvas-scanner-$OPENVAS_SCANNER_VERSION.tar.gz

#Building openvas-scanner
mkdir -p $BUILD_DIR/openvas-scanner && cd $BUILD_DIR/openvas-scanner

cmake $SOURCE_DIR/openvas-scanner-$OPENVAS_SCANNER_VERSION \
  -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
  -DCMAKE_BUILD_TYPE=Release \
  -DINSTALL_OLD_SYNC_SCRIPT=OFF \
  -DSYSCONFDIR=/etc \
  -DLOCALSTATEDIR=/var \
  -DOPENVAS_FEED_LOCK_PATH=/var/lib/openvas/feed-update.lock \
  -DOPENVAS_RUN_DIR=/run/ospd

make -j$(nproc)

#Installing openvas-scanner
mkdir -p $INSTALL_DIR/openvas-scanner

make DESTDIR=$INSTALL_DIR/openvas-scanner install

sudo cp -rv $INSTALL_DIR/openvas-scanner/* /

printf "table_driven_lsc = yes\n" | sudo tee /etc/openvas/openvas.conf
sudo printf "openvasd_server = http://127.0.0.1:3000\n" | sudo tee -a /etc/openvas/openvas.conf