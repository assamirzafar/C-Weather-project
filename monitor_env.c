// monitor_env.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <json-c/json.h>
#include "monitor_env.h"
#include "weather_utils.h"
#include "time_utils.h"

#define DEFAULT_API_KEY "your-api-key-here"  // Default API key
#define DEFAULT_CITY "Karachi"  // Default city

void print_usage(const char *program_name) {
    printf("Usage: %s [OPTIONS]\n", program_name);
    printf("Options:\n");
    printf("  -c, --city CITY        Specify the city name (default: Karachi)\n");
    printf("  -k, --api-key KEY      Specify the OpenWeatherMap API key\n");
    printf("  -h, --help             Display this help message\n");
    printf("  -l, --log              Enable logging to monitor_log.txt\n");
    printf("\nEnvironment Variables:\n");
    printf("  WEATHER_API_KEY        OpenWeatherMap API key\n");
    printf("  WEATHER_CITY           City name\n");
    printf("\nExample:\n");
    printf("  %s -c London -k your-api-key\n", program_name);
    printf("  %s --city \"New York\" --api-key your-api-key --log\n", program_name);
}

int main(int argc, char *argv[]) {
    char *city = NULL;
    char *api_key = NULL;
    int enable_logging = 0;

    // Check environment variables first
    char *env_api_key = getenv("WEATHER_API_KEY");
    char *env_city = getenv("WEATHER_CITY");

    // Parse command-line arguments
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-h") == 0 || strcmp(argv[i], "--help") == 0) {
            print_usage(argv[0]);
            return 0;
        } else if ((strcmp(argv[i], "-c") == 0 || strcmp(argv[i], "--city") == 0) && i + 1 < argc) {
            city = argv[++i];
        } else if ((strcmp(argv[i], "-k") == 0 || strcmp(argv[i], "--api-key") == 0) && i + 1 < argc) {
            api_key = argv[++i];
        } else if (strcmp(argv[i], "-l") == 0 || strcmp(argv[i], "--log") == 0) {
            enable_logging = 1;
        } else {
            fprintf(stderr, "Unknown option: %s\n", argv[i]);
            print_usage(argv[0]);
            return 1;
        }
    }

    // Set defaults if not provided
    if (api_key == NULL) {
        api_key = env_api_key ? env_api_key : DEFAULT_API_KEY;
    }
    if (city == NULL) {
        city = env_city ? env_city : DEFAULT_CITY;
    }

    // Validate API key
    if (strcmp(api_key, "your-api-key-here") == 0) {
        fprintf(stderr, "Error: Please provide a valid API key using -k option or WEATHER_API_KEY environment variable\n");
        fprintf(stderr, "Get your free API key from: https://openweathermap.org/api\n");
        return 1;
    }

    char data[2048] = "";  // To store the JSON response

    // Fetch the weather data
    printf("Fetching weather data for %s...\n", city);
    fetch_temperature(data, city, api_key);

    // Check if we got any data
    if (strlen(data) == 0) {
        fprintf(stderr, "Error: No data received from weather API\n");
        return 1;
    }

    struct json_object *parsed_json;
    struct json_object *main;
    struct json_object *temp;

    // Parse the JSON response
    parsed_json = json_tokener_parse(data);
    if (parsed_json == NULL) {
        fprintf(stderr, "Error: Failed to parse JSON response\n");
        return 1;
    }

    // Check if the response contains an error
    struct json_object *cod;
    if (json_object_object_get_ex(parsed_json, "cod", &cod)) {
        const char *code = json_object_get_string(cod);
        if (strcmp(code, "404") == 0) {
            fprintf(stderr, "Error: City '%s' not found\n", city);
            json_object_put(parsed_json);
            return 1;
        }
    }

    if (!json_object_object_get_ex(parsed_json, "main", &main)) {
        fprintf(stderr, "Error: Invalid response format from weather API\n");
        json_object_put(parsed_json);
        return 1;
    }

    if (!json_object_object_get_ex(main, "temp", &temp)) {
        fprintf(stderr, "Error: Temperature data not found in response\n");
        json_object_put(parsed_json);
        return 1;
    }

    double temperature = json_object_get_double(temp);
    
    // Get current time for display
    char timestamp[20];
    get_current_time(timestamp, sizeof(timestamp));
    
    // Display the temperature in a user-friendly format
    printf("\n");
    printf("=========================================\n");
    printf("  Weather Report - %s\n", timestamp);
    printf("=========================================\n");
    printf("  City:        %s\n", city);
    printf("  Temperature: %.2f°C\n", temperature);
    
    // Add weather condition if available
    if (temperature >= 30) {
        printf("  Condition:   🔥 Very Hot!\n");
    } else if (temperature >= 20) {
        printf("  Condition:   ☀️ Warm\n");
    } else if (temperature >= 10) {
        printf("  Condition:   🌤️ Mild\n");
    } else {
        printf("  Condition:   ❄️ Cold\n");
    }
    printf("=========================================\n");
    printf("\n");

    // Log temperature with timestamp to monitor_log.txt if enabled
    if (enable_logging) {
        FILE *log_file = fopen("monitor_log.txt", "a");
        if (log_file != NULL) {
            fprintf(log_file, "[%s] Temperature in %s: %.2f°C\n", timestamp, city, temperature);
            fclose(log_file);
            printf("Temperature logged to monitor_log.txt\n");
        } else {
            fprintf(stderr, "Warning: Could not open log file.\n");
        }
    }

    json_object_put(parsed_json);
    return 0;
}

