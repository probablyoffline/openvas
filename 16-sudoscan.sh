#!/bin/bash

###Setting up sudo for Scanning

# Create a temporary file to hold the new sudoers content
TEMP_FILE=$(mktemp)

# Backup the original sudoers file
sudo cp /etc/sudoers /etc/sudoers.bak

# Add the new lines to the temporary file
echo "%gvm ALL = NOPASSWD: /usr/local/sbin/openvas" > "$TEMP_FILE"

sudo cat "$TEMP_FILE" >> /etc/sudoers

# Clean up
sudo rm "$TEMP_FILE"
