// monitor_env.h

#ifndef MONITOR_ENV_H
#define MONITOR_ENV_H

void get_current_time(char *buffer, size_t buffer_size);
void fetch_temperature(char *data, char *city, char *api_key);

#endif  // MONITOR_ENV_H

