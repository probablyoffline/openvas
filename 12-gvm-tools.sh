#!/bin/bash

### gvm-tools
#Required dependencies for gvm-tools
sudo apt install -y \
  python3 \
  python3-pip \
  python3-venv \
  python3-setuptools \
  python3-packaging \
  python3-lxml \
  python3-defusedxml \
  python3-paramiko
  
#Installing gvm-tools system-wide
mkdir -p $INSTALL_DIR/gvm-tools

python3 -m pip install --root=$INSTALL_DIR/gvm-tools --no-warn-script-location gvm-tools

sudo cp -rv $INSTALL_DIR/gvm-tools/* /