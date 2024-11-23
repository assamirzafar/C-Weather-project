// monitor_env.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <json-c/json.h>
#include "monitor_env.h"
#include "weather_utils.h"
#include "time_utils.h"

#define API_KEY "3acaa120c764409c9d65da950a390402"  // Replace with your API key
#define CITY "Karachi"  // City for which to get the weather

int main() {
    char data[2048] = "";  // To store the JSON response

    // Fetch the weather data
    fetch_temperature(data, CITY, API_KEY);

    struct json_object *parsed_json;
    struct json_object *main;
    struct json_object *temp;

    // Parse the JSON response
    parsed_json = json_tokener_parse(data);
    json_object_object_get_ex(parsed_json, "main", &main);
    json_object_object_get_ex(main, "temp", &temp);

    double temperature = json_object_get_double(temp);
    printf("The current temperature in %s is %.2f°C\n", CITY, temperature);

    // Log temperature with timestamp to monitor_log.txt
    FILE *log_file = fopen("monitor_log.txt", "a");
    if (log_file != NULL) {
        char timestamp[20];
        get_current_time(timestamp, sizeof(timestamp));
        fprintf(log_file, "[%s] Temperature in %s: %.2f°C\n", timestamp, CITY, temperature);
        fclose(log_file);
    } else {
        fprintf(stderr, "Error opening log file.\n");
    }

    return 0;
}

