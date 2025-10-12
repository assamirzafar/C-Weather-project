#!/bin/bash

echo "================================"
echo "Weather Monitoring Setup"
echo "================================"
echo ""

# Check if running on a Debian/Ubuntu-based system
if command -v apt &> /dev/null; then
    echo "Installing dependencies using apt..."
    sudo apt update
    sudo apt install -y libcurl4-openssl-dev libjson-c-dev build-essential
    echo "Dependencies installed successfully."
elif command -v yum &> /dev/null; then
    echo "Installing dependencies using yum..."
    sudo yum install -y libcurl-devel json-c-devel gcc make
    echo "Dependencies installed successfully."
elif command -v dnf &> /dev/null; then
    echo "Installing dependencies using dnf..."
    sudo dnf install -y libcurl-devel json-c-devel gcc make
    echo "Dependencies installed successfully."
else
    echo "Warning: Could not detect package manager."
    echo "Please install the following dependencies manually:"
    echo "  - libcurl development libraries"
    echo "  - json-c development libraries"
    echo "  - GCC compiler"
    echo ""
fi

# Compile the monitor_env program using make
echo ""
echo "Compiling the weather monitoring program..."
if command -v make &> /dev/null; then
    make clean
    make
else
    # Fallback to direct gcc compilation
    gcc -Wall -Wextra -o monitor_env monitor_env.c weather_utils.c time_utils.c -lcurl -ljson-c
fi

# Check if compilation was successful
if [ -f "./monitor_env" ]; then
    echo ""
    echo "================================"
    echo "Setup Complete!"
    echo "================================"
    echo ""
    echo "The weather monitoring program has been compiled successfully."
    echo ""
    echo "Usage:"
    echo "  ./monitor_env --help                    # Show help"
    echo "  ./monitor_env -c London -k YOUR_API_KEY # Check weather for London"
    echo ""
    echo "You can also set environment variables:"
    echo "  export WEATHER_API_KEY=your-api-key-here"
    echo "  export WEATHER_CITY=London"
    echo "  ./monitor_env"
    echo ""
    echo "Get your free API key from: https://openweathermap.org/api"
    echo ""
else
    echo ""
    echo "Error: Failed to compile monitor_env"
    echo "Please check the error messages above and ensure all dependencies are installed."
    exit 1
fi

