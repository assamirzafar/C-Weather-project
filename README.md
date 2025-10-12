### Weather Monitoring Project 🌤️

This project fetches real-time temperature data for a specified city (default: Karachi) and displays the information directly in your terminal. Desktop notifications are also supported if you have a GUI environment.

---

### Features:
- Fetch real-time weather data for any city.
- Display temperature information directly in the terminal.
- Optional desktop notifications (if GUI environment is available).
- Automated setup with a single command.
- Works in both terminal-only and GUI environments.

---

### Prerequisites:
- **Linux Environment**
- **Internet Connection**
- **OpenWeatherMap API Key** 

---

### Setup Instructions:
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/assamirzafar/C-Weather-project.git
   cd C-Weather-project
   ```

2. **Run the Setup Script:**
   ```bash
   sudo ./setup.sh
   ```

   The script will:
   - Install required dependencies (`libcurl`, `libjson-c`).
   - Optionally install GUI dependencies if a desktop environment is detected.
   - Compile the C program (`monitor_env.c`).

3. **Configure Your API Key:**
   Edit `monitor_env.c` and replace `your-api-key-here` with your actual OpenWeatherMap API key:
   ```c
   #define API_KEY "your-api-key-here"  // Replace with your API key
   ```

4. **Run the Monitoring Script:**
   ```bash
   ./monitor_env.sh
   ```

   The script will:
   - Compile and run the weather monitoring program.
   - Display the current temperature in the terminal.
   - Show warnings if temperature is too hot (≥30°C).
   - Log temperature data to `monitor_log.txt`.
   - Send desktop notifications (if GUI environment is available).

---

### Optional: Automate with Crontab
You can set up a cron job to run the script automatically at regular intervals (e.g., every minute):

1. **Open the Crontab Editor:**
   ```bash
   crontab -e
   ```

2. **Add the Following Line:**
   ```bash
   * * * * * cd /path/to/C-Weather-project && ./monitor_env.sh >> /path/to/C-Weather-project/cron.log 2>&1
   ```

3. **Save and Exit:**
   - Press `Ctrl + X`, then `Y`, and `Enter`.

This will:
- Run the `monitor_env.sh` script every minute.
- Log the output to `cron.log`.

---

### Customization:
- **Change City:** Edit the `CITY` macro in `monitor_env.c`.
- **API Key:** Replace the `your-api-key-here` with your OpenWeatherMap API key in `monitor_env.c`.

### Terminal-Only Mode:
The application automatically detects whether you're running in a GUI or terminal-only environment:
- **With GUI:** You'll see terminal output AND desktop notifications.
- **Without GUI (SSH/Terminal-only):** You'll see formatted terminal output only.

This makes it perfect for:
- Remote servers accessed via SSH
- Headless systems
- Container environments
- Regular desktop use

---

### License:
This project is open-source under the MIT License. Feel free to contribute!

---

Enjoy real-time weather updates! ☀️
