#!/bin/bash

###Setting up sudo for Scanning

# Create a temporary file to hold the new sudoers content
TEMP_FILE=$(mktemp)

# Backup the original sudoers file
cp /etc/sudoers /etc/sudoers.bak

# Add the new lines to the temporary file
echo "%gvm ALL = NOPASSWD: /usr/local/sbin/openvas" > "$TEMP_FILE"

# Append the contents of the temporary file to the sudoers file using visudo to check for syntax errors
visudo -c -f <(cat /etc/sudoers "$TEMP_FILE")

if [ $? -eq 0 ]; then
  # If the syntax is correct, append the new lines to the sudoers file
  cat "$TEMP_FILE" >> /etc/sudoers
  echo "Sudoers file updated successfully."
else
  echo "Error: Syntax error in the sudoers file. Aborting."
fi

# Clean up
rm "$TEMP_FILE"
