# Quick Reference Card

## Installation
```bash
git clone https://github.com/assamirzafar/C-Weather-project.git
cd C-Weather-project
./setup.sh
```

## Basic Commands
```bash
./monitor_env --help                              # Show help
./monitor_env -c London -k YOUR_API_KEY           # Check weather
./monitor_env -c "New York" -k YOUR_KEY --log     # With logging
```

## Environment Variables
```bash
export WEATHER_API_KEY=your-api-key-here
export WEATHER_CITY=London
./monitor_env                                     # Uses env vars
```

## Make Commands
```bash
make              # Build
make clean        # Clean
make install-deps # Install dependencies
make help         # Show help
```

## Get API Key
https://openweathermap.org/api (Free tier: 60 calls/min)

## Quick Test
```bash
# With your API key:
./monitor_env -c London -k abc123xyz

# Expected output:
# Fetching weather data for London...
# =========================================
#   Weather Report - 2025-10-12 09:50:15
# =========================================
#   City:        London
#   Temperature: 15.20°C
#   Condition:   🌤️ Mild
# =========================================
```

## Automation (Cron)
```bash
# Edit crontab
crontab -e

# Add line (every hour):
0 * * * * cd /path/to/C-Weather-project && WEATHER_API_KEY=key ./monitor_env -c London --log
```

## Desktop Notifications (Optional)
```bash
./monitor_env.sh -c London -k YOUR_KEY
```
Requires: `notify-send` (install: `sudo apt install libnotify-bin`)
