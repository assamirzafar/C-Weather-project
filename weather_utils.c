// weather_utils.c

#include <stdio.h>
#include <stdlib.h>
#include <curl/curl.h>
#include <json-c/json.h>
#include <string.h>  // Include this header for strncat
#include "weather_utils.h"

// Function to write the response from the API to a string
size_t write_callback(void *ptr, size_t size, size_t nmemb, void *data) {
    strncat((char *)data, (char *)ptr, size * nmemb);  // Concatenating the response data
    return size * nmemb;
}

// Function to fetch temperature data
void fetch_temperature(char *data, char *city, char *api_key) {
    CURL *curl;
    CURLcode res;
    char url[512];
    
    snprintf(url, sizeof(url), "http://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s&units=metric", city, api_key);

    // Initialize curl
    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, data);

        // Perform the request
        res = curl_easy_perform(curl);

        if (res != CURLE_OK) {
            fprintf(stderr, "Error: %s\n", curl_easy_strerror(res));
        }

        curl_easy_cleanup(curl);
    } else {
        fprintf(stderr, "Error initializing curl.\n");
    }

    curl_global_cleanup();
}

