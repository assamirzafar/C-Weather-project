#!/bin/bash

# Update and install necessary packages
sudo apt update
sudo apt install -y libcurl4-openssl-dev libjson-c-dev

# Install optional GUI dependencies only if user has a desktop environment
if [ -n "$DISPLAY" ] || dpkg -l | grep -q "ubuntu-desktop\|gnome\|kde\|xfce"; then
    echo "Desktop environment detected. Installing GUI notification support..."
    sudo apt install -y libdbus-1-dev dbus-x11 libnotify-bin
else
    echo "No desktop environment detected. Skipping GUI notification support."
    echo "The application will work in terminal-only mode."
fi

# Install curl for API requests
sudo apt install -y curl

# Compile the monitor_env program with all required source files
gcc -o monitor_env monitor_env.c weather_utils.c time_utils.c -lcurl -ljson-c

# Check if compilation was successful
if [ -f "./monitor_env" ]; then
    echo "✓ Compilation successful!"
else
    echo "✗ Error: Compilation failed"
    exit 1
fi

# Check if the D-Bus environment is available and running (only if GUI dependencies were installed)
if command -v notify-send &> /dev/null; then
    if ! pgrep -x "dbus-daemon" > /dev/null
    then
        echo "D-Bus daemon is not running. Starting it now."
        # Start D-Bus if it's not running
        dbus-launch --sh-syntax --exit-with-session
    fi
fi

# Print confirmation message
echo ""
echo "================================================"
echo "Setup complete!"
echo "================================================"
echo "All necessary dependencies have been installed and the program has been compiled."
echo ""
echo "To run the weather monitor, execute:"
echo "  ./monitor_env.sh"
echo ""

