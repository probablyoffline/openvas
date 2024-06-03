#!/bin/bash

### greenbone-feed-sync
#Required dependencies for greenbone-feed-sync
sudo apt install -y \
  python3 \
  python3-pip
  
#Installing greenbone-feed-sync system-wide for all users
sudo apt install -y \
  python3 \
  python3-pip
  
#Installing greenbone-feed-sync system-wide for all users
mkdir -p $INSTALL_DIR/greenbone-feed-sync

python3 -m pip install --root=$INSTALL_DIR/greenbone-feed-sync --no-warn-script-location greenbone-feed-sync

sudo cp -rv $INSTALL_DIR/greenbone-feed-sync/* /