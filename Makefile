# Makefile for Weather Monitoring Project

CC = gcc
CFLAGS = -Wall -Wextra
LIBS = -lcurl -ljson-c
TARGET = monitor_env
SOURCES = monitor_env.c weather_utils.c time_utils.c
OBJECTS = $(SOURCES:.c=.o)

# Default target
all: $(TARGET)

# Build the executable
$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJECTS) $(LIBS)

# Compile source files to object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean build artifacts
clean:
	rm -f $(TARGET) $(OBJECTS) monitor_log.txt

# Install dependencies (requires sudo)
install-deps:
	sudo apt update
	sudo apt install -y libcurl4-openssl-dev libjson-c-dev

# Help target
help:
	@echo "Weather Monitoring Project - Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  make              - Build the monitor_env program"
	@echo "  make clean        - Remove built files and logs"
	@echo "  make install-deps - Install required dependencies (requires sudo)"
	@echo "  make help         - Show this help message"
	@echo ""
	@echo "Usage examples:"
	@echo "  ./monitor_env --help"
	@echo "  ./monitor_env -c London -k YOUR_API_KEY"
	@echo "  WEATHER_API_KEY=YOUR_KEY ./monitor_env -c Paris"

.PHONY: all clean install-deps help
