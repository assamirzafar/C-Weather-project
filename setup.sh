#!/bin/bash

# Update and install necessary packages
sudo apt update
sudo apt install -y libcurl4-openssl-dev libjson-c-dev libdbus-1-dev dbus-x11 libnotify-bin

# Ensure curl and json-c are installed for your C program
sudo apt install -y curl json-c

# Compile the monitor_env program
gcc -o monitor_env monitor_env.c -lcurl -ljson-c

# Check if the D-Bus environment is available and running
if ! pgrep -x "dbus-daemon" > /dev/null
then
    echo "D-Bus daemon is not running. Starting it now."
    # Start D-Bus if it's not running
    dbus-launch --sh-syntax --exit-with-session
fi

# Print confirmation message
echo "Setup complete. All necessary dependencies have been installed and the program has been compiled."

