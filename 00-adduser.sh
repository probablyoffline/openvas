#!/bin/bash

#Creating a gvm system user and group
sudo useradd -r -M -U -G sudo -s /usr/sbin/nologin gvm

#Add current user to gvm group
sudo usermod -aG gvm $USER
exec su $USER

./01-prereqs.sh