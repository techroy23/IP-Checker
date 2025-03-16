# IP-Checker
#### IP-Checker is a Bash script designed to fetch and display your public IP address from multiple reliable online services. It ensures redundancy and reliability by iterating through various IP-checking endpoints. If one service fails, the script seamlessly attempts the next.

## Features
- Checks your public IP address using a curated list of online services.
- Validates the responses to ensure they are valid IPv4 addresses.
- Provides detailed output, including the source of each retrieved IP.
- Offers redundancy by cycling through multiple IP-checking services.

## How It Works
- This script iterates over a list of predefined IP-checking websites. For each service:
  - It sends a curl request to fetch the public IP address.
  - It validates the response to ensure it conforms to a valid IPv4 format.
  - It displays the result, indicating whether the retrieval was successful or not.

## Usage
 - Prerequisites
  - A Unix-like environment (Linux, macOS, or WSL).
  - curl installed on the system.

## Instructions
Clone the repository:
```
git clone https://github.com/techroy23/IP-Checker.git
cd IP-Checker
chmod +x ip-checker.sh
./ip-checker.sh
```

## Sample Output
```
Attempting to fetch your public IP address from various sources...
==============================================================
Retrieved IP: XXX.XXX.XXX.XXX (via ifconfig.me)
Retrieved IP: XXX.XXX.XXX.XXX (via ipinfo.io/ip)
Retrieved IP: XXX.XXX.XXX.XXX (via icanhazip.com)
Retrieved IP: XXX.XXX.XXX.XXX (via checkip.amazonaws.com)
Retrieved IP: XXX.XXX.XXX.XXX (via whatismyip.akamai.com)
Retrieved IP: XXX.XXX.XXX.XXX (via ip.tyk.nu)
Retrieved IP: XXX.XXX.XXX.XXX (via api64.ipify.org)
Retrieved IP: XXX.XXX.XXX.XXX (via ident.me)
Retrieved IP: XXX.XXX.XXX.XXX (via wtfismyip.com/text)
==============================================================
All IP checks completed.
```

## IP-Checking Services
The script queries the following services for your public IP:
- ifconfig.me
- ipinfo.io/ip
- icanhazip.com
- checkip.amazonaws.com
- whatismyip.akamai.com
- ip.tyk.nu
- api64.ipify.org
- ident.me
- wtfismyip.com/text
