#!/bin/sh
###############################################################################
#                                                                             #
#                        PUBLIC IP ADDRESS CHECKER                            #
#                                                                             #
# Description:                                                                #
#   This script queries multiple external services to determine the           #
#   machine's public IP address. It supports both IPv4 and IPv6 detection.    #
#   Tested 2026-06-06 — 66 services verified working.                      #
#                                                                             #
# Features:                                                                   #
#   - Randomized User-Agent string to mimic browser requests                  #
#   - Optional "unsecure mode" to skip SSL verification                       #
#   - Debug mode for detailed output (raw response + parsed IP)               #
#   - Tabular output for readability                                          #
#                                                                             #
# Usage:                                                                      #
#   Run directly in a POSIX shell environment.                                #
#   Modify UNSECURE_MODE or DEBUG_MODE as needed.                             #
#                                                                             #
#   curl -fsSL bit.ly/an2kin-ip-checker | sh                                  #
#   git clone https://github.com/techroy23/IP-Checker                         #
#                                                                             #
###############################################################################

# ----------------------------- CONFIGURATION -------------------------------- #
UNSECURE_MODE="true"   			# If true, disables SSL certificate verification (-k).
DEBUG_MODE="false"     			# If true, prints raw responses for debugging.
CURL_OPTS="-s -L --max-time 5"  # Base curl options: silent, follow redirects, timeout.

# ----------------------------- USER-AGENT SETUP ----------------------------- #
# Randomize minor version and Gecko build.
rv_minor=$((RANDOM % 10))
gecko_build=$((20200101 + RANDOM % 99999))
ua="Mozilla/5.0 (X11; Linux x86_64; rv:100.$rv_minor) Gecko/$gecko_build Firefox/100.$rv_minor"

# Append User-Agent to curl options
CURL_OPTS="$CURL_OPTS -A \"$ua\""

# Enable insecure mode if configured
[ "$UNSECURE_MODE" = "true" ] && CURL_OPTS="$CURL_OPTS -k"

# ----------------------------- IP SERVICES LIST ----------------------------- #
# All services verified working as of 2026-06-06 — 66 total
# Sorted alphabetically
ip_services="
    4.ipwho.de/ip
    4.myip.is
    6.ident.me
    6.myip.is
    a.ident.me
    api.getpublicip.com/ip
    api.ipify.org
    api.iplocation.net/?cmd=get-ip
    api.seeip.org
    api64.ipify.org
    checkip.amazonaws.com
    checkip.ca
    checkip.synology.com
    dafuqismyip.com
    ds-whoami.kag2d.com
    eth0.me
    httpbin.org/ip
    icanhazip.com
    ident.me
    ifconfig.icu/ip
    ifconfig.info
    ifconfig.io
    ifconfig.me/ip
    inet-ip.info
    ip-addr.es
    ip-echo.ripe.net
    ip.csis.dk
    ip.guide
    ip.im
    ip.liquidweb.com
    ip.me
    ip.tyk.nu
    ip6.me/api
    ipaddress.ai
    ipapi.co/ip
    ipconfig.io
    ipecho.net/ip
    iphorse.com/json
    ipinfo.io/ip
    ipleak.net
    ipquail.com
    ipseeker.io
    ipunicorn.com
    ipv4.getpublicip.com/ip
    ipv6.icanhazip.com
    ipv6.ip.sb
    json.myip.wtf
    jsonip.com
    l2.io/ip
    moanmyip.com/simple
    my.ip.fi
    myexternalip.com/raw
    myip.dk
    myip.dnsomatic.com
    myip.wtf/text
    pub-ip.com
    simplesniff.com/ip
    sshmyip.com
    telnetmyip.com
    v4.ident.me
    v6.ident.me
    wgetip.com
    whatismyip.akamai.com
    whatismyip.help
    wtfismyip.com/text
    yourip.app/raw
"

# ----------------------------- OUTPUT BANNER -------------------------------- #
echo ""
echo "=================================================================="
echo "                 PUBLIC IP ADDRESS CHECKER                        "
echo "=================================================================="
echo ""

# ----------------------------- TABLE HEADER ------------------------------- #
# Determine max length of service names for alignment.
maxlen=0
for service in $ip_services; do
    len=${#service}
    [ $len -gt $maxlen ] && maxlen=$len
done
pad=$((maxlen + 2))

# Print header depending on DEBUG_MODE.
if [ "$DEBUG_MODE" = "true" ]; then
    printf "%-${pad}s | %-15s | %s\n" "SOURCE" "RESPONSE" "RAW"
    printf "%-${pad}s-+-%-15s-+-%s\n" "$(printf '%*s' $pad | tr ' ' '-')" "---------------" "----------------"
else
    printf "%-${pad}s | %s\n" "SOURCE" "RESPONSE"
    printf "%-${pad}s-+-%s\n" "$(printf '%*s' $pad | tr ' ' '-')" "----------------"
fi

# ----------------------------- MAIN LOOP ----------------------------------- #
# Query each service, parse response, and print result.
for service in $ip_services; do
    # Skip comment lines
    case "$service" in
        \#*) continue ;;
    esac
    [ -z "$service" ] && continue

    # Execute curl with configured options.
    response=$(eval curl $CURL_OPTS "$service" 2>/dev/null)

    # Clean response (remove newlines/carriage returns).
    clean_response=$(echo "$response" | tr -d '\r\n')

    # Try to extract IPv6 first.
    ip=$(echo "$clean_response" | grep -Eo '([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}' | head -n1)

    # If no IPv6 found, fallback to IPv4.
    if [ -z "$ip" ]; then
        ip=$(echo "$clean_response" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -n1)
    fi

    # If still empty, mark as unavailable.
    [ -n "$ip" ] && out="$ip" || out=" - - - "

    # Print depending on DEBUG_MODE.
    if [ "$DEBUG_MODE" = "true" ]; then
        printf "%-${pad}s | %-15s | %s\n" "$service" "$out" "$clean_response"
    else
        printf "%-${pad}s | %s\n" "$service" "$out"
    fi
done
echo ""

###############################################################################
# End of Script                                                               #
#                                                                             #
# Notes:                                                                      #
#   - This script is useful for redundancy: multiple services ensure          #
#     availability even if one provider is down.                              #
#   - Debug mode helps diagnose parsing issues or service anomalies.          #
#   - Full test results: https://github.com/techroy23/IP-Checker              #
#                                                                             #
###############################################################################
