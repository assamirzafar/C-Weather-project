#!/bin/bash
# Optional script for running with desktop notifications
# This script is now OPTIONAL - you can run ./monitor_env directly for terminal-only usage

# Check if notify-send is available
if ! command -v notify-send &> /dev/null; then
    echo "Warning: notify-send not found. Desktop notifications will not work."
    echo "Running in terminal-only mode..."
    ./monitor_env "$@"
    exit $?
fi

# Set up D-Bus environment for desktop notifications (if needed)
if [ -n "$DISPLAY" ] && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    # Try to find the user's D-Bus session
    if [ -e "/run/user/$(id -u)/bus" ]; then
        export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
    fi
fi

# Build the program if not already built
if [ ! -f "./monitor_env" ]; then
    echo "Program not built. Building now..."
    if command -v make &> /dev/null; then
        make
    else
        gcc -Wall -Wextra -o monitor_env monitor_env.c weather_utils.c time_utils.c -lcurl -ljson-c
    fi
    
    if [ ! -f "./monitor_env" ]; then
        echo "Error: Failed to compile monitor_env"
        exit 1
    fi
fi

# Run the compiled program and capture its output
output=$(./monitor_env "$@")
exit_code=$?

# Print the output to the terminal
echo "$output"

# If the program failed, exit with the same code
if [ $exit_code -ne 0 ]; then
    exit $exit_code
fi

# Extract the temperature from the output
current_temp=$(echo "$output" | grep -oP 'Temperature:\s+\K[0-9.]+')

# Check if the temperature was extracted successfully
if [ -n "$current_temp" ]; then
    # Extract city name
    city=$(echo "$output" | grep -oP 'City:\s+\K.*')
    
    # If the temperature is above or equal to 30°C, send a critical warning notification
    if command -v bc &> /dev/null && (( $(echo "$current_temp >= 30" | bc -l) )); then
        notify-send "🔥 Critical Temperature Warning" "Temperature in ${city}: ${current_temp}°C - Too Hot!" -u critical
    else
        # Otherwise, send a regular temperature update
        notify-send "🌤️ Weather Update" "Temperature in ${city}: ${current_temp}°C"
    fi
else
    # Notify the user that the temperature couldn't be retrieved
    notify-send "⚠️ Weather Update Error" "Failed to retrieve temperature data."
fi

