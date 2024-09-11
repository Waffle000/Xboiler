#!/bin/bash

# URL to the binary release from GitHub
BIN_URL="https://github.com/Waffle000/Xboiler/releases/download/v0.1.0-beta.1/xboiler"
INSTALL_PATH="/usr/local/bin/xboiler"

# Download the binary using sudo
echo "Downloading xboiler from $BIN_URL..."
curl -L $BIN_URL -o /tmp/xboiler

# Move the binary to /usr/local/bin with sudo
echo "Moving xboiler to $INSTALL_PATH..."
sudo mv /tmp/xboiler $INSTALL_PATH

# Set execute permissions with sudo
echo "Setting executable permissions for xboiler..."
sudo chmod +x $INSTALL_PATH

# Verify installation
if [ -f "$INSTALL_PATH" ]; then
    echo "xboiler successfully installed at $INSTALL_PATH"
else
    echo "Failed to install xboiler."
    exit 1
fi

# Display xboiler version
$INSTALL_PATH --version
