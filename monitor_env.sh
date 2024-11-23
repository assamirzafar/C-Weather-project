#!/bin/bash

# Set display for cron jobs to send desktop notifications
#export DISPLAY=:0
# Export the D-Bus session address for notify-send to work

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

# Compile the C program with required libraries
gcc -o monitor_env monitor_env.c weather_utils.c time_utils.c -lcurl -ljson-c

# Check if the C program was compiled successfully
if [ ! -f "./monitor_env" ]; then
    echo "Error: Failed to compile monitor_env.c"
    exit 1
fi

# Run the compiled program and capture its output
output=$(./monitor_env)

# Print the output to the terminal for debugging
echo "$output"

# Extract the temperature from the output
current_temp=$(echo "$output" | grep -oP 'The current temperature in .* is \K[0-9.]+')

# Check if the temperature was extracted successfully
if [ -n "$current_temp" ]; then
    # Print the current temperature to the terminal
    #echo "Current Temperature: ${current_temp}°C"
    

    # If the temperature is above or equal to 30°C, send a critical warning notification
    if (( $(echo "$current_temp >= 30" | bc -l) )); then
        notify-send "Critical Temperature Warning" "Current Temperature: ${current_temp}°C - Too Hot!"
    else
        # Otherwise, send a regular temperature update
        notify-send "Real-Time Temperature Update" "Current Temperature: ${current_temp}°C"
    fi
    
    # Optionally log the notification to a file (in the same directory)
    # echo "$(date): Current Temperature: ${current_temp}°C" >> monitor_log.txt
else
    # Notify the user that the temperature couldn't be retrieved
    echo "$(date): Error: Failed to extract temperature" >> monitor_log.txt
    notify-send "Temperature Update Error" "Failed to retrieve temperature data."
fi

