#!/bin/bash

###Performing a System Setup

#Installing the Redis server
sudo apt install -y redis-server

#Adding configuration for running the Redis server for the scanner
sudo cp $SOURCE_DIR/openvas-scanner-$OPENVAS_SCANNER_VERSION/config/redis-openvas.conf /etc/redis/
sudo chown redis:redis /etc/redis/redis-openvas.conf
echo "db_address = /run/redis-openvas/redis.sock" | sudo tee -a /etc/openvas/openvas.conf

#Start redis with openvas config
sudo systemctl start redis-server@openvas.service

#Ensure redis with openvas config is started on every system startup
sudo systemctl enable redis-server@openvas.service

#Adding the gvm user to the redis group
sudo usermod -aG redis gvm