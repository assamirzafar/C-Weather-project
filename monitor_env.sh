#!/bin/bash

# Set DISPLAY and DBUS only if they are not already set
# This makes the script work in both GUI and terminal-only environments
if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
fi

# Compile the C program with required libraries
gcc -o monitor_env monitor_env.c weather_utils.c time_utils.c -lcurl -ljson-c

# Check if the C program was compiled successfully
if [ ! -f "./monitor_env" ]; then
    echo "Error: Failed to compile monitor_env.c"
    exit 1
fi

# Run the compiled program and capture its output
output=$(./monitor_env)

# Print the output to the terminal
echo "$output"

# Extract the temperature from the output
current_temp=$(echo "$output" | grep -oP 'The current temperature in .* is \K[0-9.]+')

# Check if the temperature was extracted successfully
if [ -n "$current_temp" ]; then
    # Print the current temperature to the terminal
    echo "================================================"
    echo "Current Temperature: ${current_temp}°C"
    
    # If the temperature is above or equal to 30°C, print a critical warning
    if (( $(echo "$current_temp >= 30" | bc -l) )); then
        echo "⚠️  CRITICAL WARNING: Temperature is too hot!"
        echo "================================================"
        
        # Try to send desktop notification if notify-send is available and DISPLAY is set
        if command -v notify-send &> /dev/null && [ -n "$DISPLAY" ]; then
            notify-send "Critical Temperature Warning" "Current Temperature: ${current_temp}°C - Too Hot!" 2>/dev/null
        fi
    else
        echo "✓ Temperature is normal"
        echo "================================================"
        
        # Try to send desktop notification if notify-send is available and DISPLAY is set
        if command -v notify-send &> /dev/null && [ -n "$DISPLAY" ]; then
            notify-send "Real-Time Temperature Update" "Current Temperature: ${current_temp}°C" 2>/dev/null
        fi
    fi
    
    # Log the notification to a file
    echo "$(date): Current Temperature: ${current_temp}°C" >> monitor_log.txt
else
    # Notify the user that the temperature couldn't be retrieved
    echo "================================================"
    echo "❌ Error: Failed to retrieve temperature data"
    echo "================================================"
    echo "$(date): Error: Failed to extract temperature" >> monitor_log.txt
    
    # Try to send desktop notification if available
    if command -v notify-send &> /dev/null && [ -n "$DISPLAY" ]; then
        notify-send "Temperature Update Error" "Failed to retrieve temperature data." 2>/dev/null
    fi
fi

