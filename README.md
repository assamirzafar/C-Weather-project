### Weather Monitoring Project 🌤️

This project fetches real-time temperature data for a specified city (default: Karachi) and displays desktop notifications. The `setup.sh` script will automatically install dependencies and compile the C program.

---

### Features:
- Fetch real-time weather data for any city.
- Display desktop notifications with the current temperature.
- Automated setup with a single command.

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
   - Compile the C program (`monitor_env.c`).

3. **Run the Monitoring Script:**
   ```bash
   ./monitor_env.sh
   ```

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
- **API Key:** Replace the `you-api-key-here` with your OpenWeatherMap API key.

---

### License:
This project is open-source under the MIT License. Feel free to contribute!

---

Enjoy real-time weather updates! ☀️
