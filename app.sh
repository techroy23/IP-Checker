#!/bin/sh

# Script to check the public IP address using multiple online services.
# This script iterates over a list of IP-checking websites and attempts
# to retrieve your public IP address for redundancy and reliability.

# Define a collection of websites to check IP
# Each service provides a simple endpoint that returns the current public IP.
ip_services="
    eth0.me
    ifconfig.icu/ip
    ifconfig.me
    ipinfo.io/ip
    icanhazip.com
    checkip.amazonaws.com
    whatismyip.akamai.com
    ip.tyk.nu
    api64.ipify.org
    ident.me
    wtfismyip.com/text
"

# Notify the user of the task being performed
printf "\nAttempting to fetch your public IP address from various sources...\n"
printf "==============================================================\n"

# Iterate through each service and fetch IP address
for service in $ip_services; do
    # Use curl to make a request to the service and capture the response
    response=$(curl -s "$service")
    
    # Validate the response to ensure it is a valid IPv4 address
    if echo "$response" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$'; then
        # Print the retrieved IP and the source service
        printf "Retrieved IP: %s (via %s)\n" "$response" "$service"
    else
        # Print an error message if the response is not a valid IP
        printf "Failed to fetch valid IP from %s.\n" "$service"
    fi
done

# Final message indicating completion of the task
printf "==============================================================\n"
printf "All IP checks completed.\n"
