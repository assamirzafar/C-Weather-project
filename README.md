### Weather Monitoring Project 🌤️

This project fetches real-time temperature data for any city and displays it directly in your terminal. It now supports command-line arguments, making it easy to use on any PC without complex setup.

---

### Features:
- ✅ Fetch real-time weather data for any city
- ✅ Works directly in terminal - no GUI required
- ✅ Command-line arguments for easy customization
- ✅ Environment variable support
- ✅ Optional desktop notifications (if available)
- ✅ Cross-platform support (Linux, macOS)
- ✅ Optional logging to file
- ✅ Simple Makefile for easy compilation

---

### Prerequisites:
- **C Compiler (gcc)** - Usually pre-installed on Linux/macOS
- **libcurl** - For making HTTP requests
- **json-c** - For parsing JSON responses
- **OpenWeatherMap API Key** - Get one free at [OpenWeatherMap](https://openweathermap.org/api)

---

### Quick Start:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/assamirzafar/C-Weather-project.git
   cd C-Weather-project
   ```

2. **Run the Setup Script:**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   
   The script will:
   - Install required dependencies (libcurl, json-c)
   - Compile the program using the Makefile

3. **Run the Program:**
   
   **Option 1: Using command-line arguments**
   ```bash
   ./monitor_env -c London -k your-api-key-here
   ```
   
   **Option 2: Using environment variables**
   ```bash
   export WEATHER_API_KEY=your-api-key-here
   export WEATHER_CITY=London
   ./monitor_env
   ```
   
   **Option 3: With logging enabled**
   ```bash
   ./monitor_env -c "New York" -k your-api-key-here --log
   ```

---

### Usage Guide:

**Display help message:**
```bash
./monitor_env --help
```

**Check weather for a specific city:**
```bash
./monitor_env --city "Paris" --api-key your-api-key-here
```

**Use short options:**
```bash
./monitor_env -c Tokyo -k your-api-key-here
```

**Enable logging:**
```bash
./monitor_env -c Mumbai -k your-api-key-here --log
```

---

### Command-Line Options:

| Option | Short | Description |
|--------|-------|-------------|
| `--city CITY` | `-c` | Specify the city name (default: Karachi) |
| `--api-key KEY` | `-k` | Specify your OpenWeatherMap API key |
| `--log` | `-l` | Enable logging to monitor_log.txt |
| `--help` | `-h` | Display help message |

---

### Environment Variables:

You can set these environment variables to avoid passing arguments every time:

```bash
export WEATHER_API_KEY=your-api-key-here
export WEATHER_CITY=London
```

Then simply run:
```bash
./monitor_env
```

---

### Building from Source:

**Using Make (recommended):**
```bash
make              # Build the program
make clean        # Clean build artifacts
make install-deps # Install dependencies (requires sudo)
make help         # Show help
```

**Manual compilation:**
```bash
gcc -Wall -Wextra -o monitor_env monitor_env.c weather_utils.c time_utils.c -lcurl -ljson-c
```

---

### Optional: Desktop Notifications

If you want desktop notifications along with terminal output, use the `monitor_env.sh` wrapper script:

```bash
chmod +x monitor_env.sh
./monitor_env.sh -c London -k your-api-key-here
```

This requires `notify-send` (install with `sudo apt install libnotify-bin` on Ubuntu/Debian).

---


### Optional: Automate with Crontab

You can set up a cron job to run the program automatically at regular intervals:

1. **Open the Crontab Editor:**
   ```bash
   crontab -e
   ```

2. **Add a Line (Example: Every hour):**
   ```bash
   0 * * * * cd /path/to/C-Weather-project && WEATHER_API_KEY=your-key ./monitor_env -c Karachi --log >> /path/to/C-Weather-project/cron.log 2>&1
   ```

3. **Save and Exit:**
   - Press `Ctrl + X`, then `Y`, and `Enter`.

This will:
- Run the weather check every hour
- Log the output to `cron.log`
- Save temperature data to `monitor_log.txt`

---

### Customization:

**Change Default City:**
Edit the `DEFAULT_CITY` macro in `monitor_env.c` or use the `-c` option.

**Change Default API Key:**
Edit the `DEFAULT_API_KEY` macro in `monitor_env.c` or use the `-k` option (or environment variable).

**Modify Output Format:**
Edit the display section in `monitor_env.c` to customize the output.

---

### Troubleshooting:

**"Please provide a valid API key" error:**
- Make sure you've replaced `your-api-key-here` with your actual API key
- Get a free key from https://openweathermap.org/api

**"City not found" error:**
- Check the spelling of the city name
- Try using the city name in English
- Some cities may require the country code (e.g., "London,UK")

**Compilation errors:**
- Make sure you have all dependencies installed
- Run `./setup.sh` to install dependencies automatically
- Try manual compilation with the gcc command shown above

**Connection errors:**
- Check your internet connection
- Verify the API key is valid and active
- Check if you've exceeded the API rate limit (60 calls/min for free tier)

---

### Project Structure:

```
C-Weather-project/
├── monitor_env.c       # Main program with CLI argument support
├── weather_utils.c     # Weather API fetching functions
├── time_utils.c        # Time/date utility functions
├── monitor_env.h       # Header file
├── weather_utils.h     # Header file
├── time_utils.h        # Header file
├── Makefile            # Build automation
├── setup.sh            # Automated setup script
├── monitor_env.sh      # Optional wrapper for desktop notifications
└── README.md           # This file
```

---

### License:
This project is open-source under the MIT License. Feel free to contribute!

---

Enjoy real-time weather updates directly in your terminal! 🌤️☀️❄️
