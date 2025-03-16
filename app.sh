#!/bin/bash

# Script to check the public IP address using multiple online services.
# This script iterates over a list of IP-checking websites and attempts
# to retrieve your public IP address for redundancy and reliability.

# Define a collection of websites to check IP
# Each service provides a simple endpoint that returns the current public IP.
ip_services=(
    "ifconfig.me"
    "ipinfo.io/ip"
    "icanhazip.com"
    "checkip.amazonaws.com"
    "whatismyip.akamai.com"
    "ip.tyk.nu"
    "api64.ipify.org"
    "ident.me"
    "wtfismyip.com/text"
)

# Notify the user of the task being performed
echo -e "\nAttempting to fetch your public IP address from various sources..."
echo "=============================================================="

# Iterate through each service and fetch IP address
for service in "${ip_services[@]}"; do
    # Use curl to make a request to the service and capture the response
    response=$(curl -s "$service")
    
    # Validate the response to ensure it is a valid IPv4 address
    if [[ $response =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        # Print the retrieved IP and the source service
        echo "Retrieved IP: $response (via $service)"
    else
        # Print an error message if the response is not a valid IP
        echo "Failed to fetch valid IP from $service."
    fi
done

# Final message indicating completion of the task
echo "=============================================================="
echo -e "All IP checks completed.\n"
