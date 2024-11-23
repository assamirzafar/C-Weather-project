// weather_utils.h

#ifndef WEATHER_UTILS_H
#define WEATHER_UTILS_H

#include <curl/curl.h>

// Function prototype to fetch temperature data
void fetch_temperature(char *data, char *city, char *api_key);

#endif  // WEATHER_UTILS_H

