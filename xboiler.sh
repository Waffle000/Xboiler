#!/bin/bash

# URL of the binary release from GitHub
BIN_URL="https://github.com/Waffle000/Xboiler/releases/download/v0.1.0-beta.1/xboiler"
INSTALL_PATH="/usr/local/bin/xboiler"

# Download the binary
echo "Downloading xboiler from $BIN_URL..."
curl -L $BIN_URL -o $INSTALL_PATH

# Set execute permissions
echo "Setting executable permissions for xboiler..."
chmod +x $INSTALL_PATH

# Verify installation
if [ -f "$INSTALL_PATH" ]; then
    echo "xboiler successfully installed at $INSTALL_PATH"
else
    echo "Failed to install xboiler."
    exit 1
fi

# Display the version of xboiler
$INSTALL_PATH --version
