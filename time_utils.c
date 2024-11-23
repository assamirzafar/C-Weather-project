// time_utils.c

#include <stdio.h>
#include <time.h>
#include "time_utils.h"

// Function to get the current timestamp
void get_current_time(char *buffer, size_t buffer_size) {
    time_t now = time(NULL);
    struct tm *t = localtime(&now);
    strftime(buffer, buffer_size, "%Y-%m-%d %H:%M:%S", t);
}

