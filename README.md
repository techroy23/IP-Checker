# IP-Checker

**66 public IP services** — IPv4 & IPv6. Redundant. Reliable.

Queries a curated list of external services to determine your public IP address. If one service fails, the script seamlessly tries the next. Supports both IPv4 and IPv6 auto-detection.

## Features

- 66 services tested and verified working (2026-06-06)
- IPv4 + IPv6 auto-detection
- Randomized User-Agent to avoid blocking
- Debug mode for raw response inspection
- Tabular output

## Usage

```bash
curl -fsSL bit.ly/an2kin-ip-checker | sh
```

or

```bash
git clone https://github.com/techroy23/IP-Checker
cd IP-Checker
chmod +x app.sh
./app.sh
```

## Sample Output

```
==================================================================
                 PUBLIC IP ADDRESS CHECKER                        
==================================================================

SOURCE                           | RESPONSE
---------------------------------+----------------
ifconfig.icu/ip                  | XXX.XXX.XXX.XXX
ifconfig.me/ip                   | XXX.XXX.XXX.XXX
ipecho.net/ip                    | XXX.XXX.XXX.XXX
4.ipwho.de/ip                    | XXX.XXX.XXX.XXX
ipinfo.io/ip                     | XXX.XXX.XXX.XXX
icanhazip.com                    | XXX.XXX.XXX.XXX
...
```

## Sources

`4.ipwho.de/ip`, `4.myip.is`, `6.ident.me`, `6.myip.is`, `a.ident.me`, `api.getpublicip.com/ip`, `api.ipify.org`, `api.iplocation.net/?cmd=get-ip`, `api.seeip.org`, `api64.ipify.org`, `checkip.amazonaws.com`, `checkip.ca`, `checkip.synology.com`, `dafuqismyip.com`, `ds-whoami.kag2d.com`, `eth0.me`, `httpbin.org/ip`, `icanhazip.com`, `ident.me`, `ifconfig.icu/ip`, `ifconfig.info`, `ifconfig.io`, `ifconfig.me/ip`, `inet-ip.info`, `ip-addr.es`, `ip-echo.ripe.net`, `ip.csis.dk`, `ip.guide`, `ip.im`, `ip.liquidweb.com`, `ip.me`, `ip.tyk.nu`, `ip6.me/api`, `ipaddress.ai`, `ipapi.co/ip`, `ipconfig.io`, `ipecho.net/ip`, `iphorse.com/json`, `ipinfo.io/ip`, `ipleak.net`, `ipquail.com`, `ipseeker.io`, `ipunicorn.com`, `ipv4.getpublicip.com/ip`, `ipv6.icanhazip.com`, `ipv6.ip.sb`, `json.myip.wtf`, `jsonip.com`, `l2.io/ip`, `moanmyip.com/simple`, `my.ip.fi`, `myexternalip.com/raw`, `myip.dk`, `myip.dnsomatic.com`, `myip.wtf/text`, `pub-ip.com`, `simplesniff.com/ip`, `sshmyip.com`, `telnetmyip.com`, `v4.ident.me`, `v6.ident.me`, `wgetip.com`, `whatismyip.akamai.com`, `whatismyip.help`, `wtfismyip.com/text`, `yourip.app/raw`

## Configuration

Edit `app.sh` to toggle:

- `UNSECURE_MODE="true"` — skip SSL verification (`-k` flag)
- `DEBUG_MODE="false"` — show raw HTTP response for each service
