# Usage Examples

This document provides comprehensive examples for using the Weather Monitoring Program.

## Basic Usage

### 1. Get Help
```bash
./monitor_env --help
```

### 2. Check Weather with API Key
```bash
./monitor_env -c London -k your-api-key-here
```

### 3. Check Weather with Long Options
```bash
./monitor_env --city "New York" --api-key your-api-key-here
```

## Using Environment Variables

### Set API Key Once
```bash
export WEATHER_API_KEY=your-api-key-here
./monitor_env -c Tokyo
./monitor_env -c Paris
./monitor_env -c Berlin
```

### Set Both City and API Key
```bash
export WEATHER_API_KEY=your-api-key-here
export WEATHER_CITY=London
./monitor_env
```

## Logging

### Enable Logging to File
```bash
./monitor_env -c Mumbai --api-key your-key --log
```

This will create/append to `monitor_log.txt` with timestamped entries.

### View Log File
```bash
cat monitor_log.txt
```

Example output:
```
[2025-10-12 09:50:15] Temperature in Mumbai: 32.50°C
[2025-10-12 09:55:20] Temperature in London: 15.20°C
```

## Advanced Usage

### Using in Shell Scripts
```bash
#!/bin/bash
export WEATHER_API_KEY=your-api-key-here

# Check multiple cities
for city in London Paris Tokyo "New York"; do
    echo "Checking weather for $city..."
    ./monitor_env -c "$city"
    echo "---"
done
```

### Automated Monitoring with Cron

**Every hour:**
```bash
0 * * * * cd /path/to/C-Weather-project && WEATHER_API_KEY=your-key ./monitor_env -c London --log >> cron.log 2>&1
```

**Every 6 hours:**
```bash
0 */6 * * * cd /path/to/C-Weather-project && WEATHER_API_KEY=your-key ./monitor_env -c Paris --log
```

**Daily at 8 AM:**
```bash
0 8 * * * cd /path/to/C-Weather-project && WEATHER_API_KEY=your-key ./monitor_env -c Tokyo --log
```

### Desktop Notifications (Optional)

Use the wrapper script for desktop notifications:
```bash
./monitor_env.sh -c London -k your-api-key-here
```

This will:
- Display weather in terminal
- Show desktop notification (if `notify-send` is available)
- Use different notification styles based on temperature

## Building and Maintenance

### Build from Source
```bash
make
```

### Clean Build Artifacts
```bash
make clean
```

### Rebuild Everything
```bash
make clean
make
```

### Install Dependencies
```bash
make install-deps
```

Or use the setup script:
```bash
./setup.sh
```

## API Key Management

### Option 1: Command Line (Temporary)
```bash
./monitor_env -c London -k abc123xyz
```

### Option 2: Environment Variable (Session)
```bash
export WEATHER_API_KEY=abc123xyz
./monitor_env -c London
```

### Option 3: Shell Profile (Permanent)
Add to `~/.bashrc` or `~/.zshrc`:
```bash
export WEATHER_API_KEY=abc123xyz
export WEATHER_CITY=London
```

Then reload:
```bash
source ~/.bashrc
./monitor_env
```

## Troubleshooting

### "City not found" Error
Try adding country code:
```bash
./monitor_env -c "London,UK" -k your-key
./monitor_env -c "Paris,FR" -k your-key
```

### Connection Issues
Check your internet connection and API key validity:
```bash
# Test with curl
curl "http://api.openweathermap.org/data/2.5/weather?q=London&appid=your-key"
```

### Compilation Errors
Ensure dependencies are installed:
```bash
./setup.sh
```

Or manually:
```bash
sudo apt install libcurl4-openssl-dev libjson-c-dev
```

## Sample Output

When you run the program successfully, you'll see:
```
Fetching weather data for London...

=========================================
  Weather Report - 2025-10-12 09:50:15
=========================================
  City:        London
  Temperature: 15.20°C
  Condition:   🌤️ Mild
=========================================

Temperature logged to monitor_log.txt
```

## Getting Your API Key

1. Visit: https://openweathermap.org/api
2. Sign up for a free account
3. Navigate to API Keys section
4. Copy your API key
5. Use it with the `-k` option or `WEATHER_API_KEY` environment variable

Free tier includes:
- 60 calls per minute
- 1,000,000 calls per month
- Current weather data
