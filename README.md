# Magisk LAN Auto Switch
Automatically switch LAN and WiFi based on eth0 connection status.

## Overview
Magisk LAN Auto Switch is a Magisk module that checks the `eth0` connection after boot and toggles WiFi accordingly. If `eth0` is not connected, the module will turn on the WiFi; otherwise, it will turn off the WiFi. The check is performed 3 seconds after the boot completes.

## Features
- Runs automatically after boot.
- Checks the `eth0` connection status.
- Toggles WiFi based on the `eth0` connection status.

## Installation
1. Download the `magisk-lan-auto-switch.zip` file from the [Releases](https://github.com/NewFuture/magisk-lan-auto-switch/releases) page.
2. Open the Magisk app.
3. Go to the Modules section.
4. Tap on the "Install from storage" button.
5. Select the `magisk-lan-auto-switch.zip` file.
6. Reboot your device.

## Module Structure
```
magisk-lan-auto-switch
├── module.prop
├── service.sh
└── META-INF
```
### `service.sh`
This script runs 3 seconds after boot and checks the `eth0` connection status:
```shell
#!/system/bin/sh

# Delay execution by 3 seconds
sleep 3

# Check if eth0 is connected
ETH0_CONNECTED=$(cat /sys/class/net/eth0/carrier 2>/dev/null)

if [ "$ETH0_CONNECTED" = "1" ]; then
    # eth0 is connected, turn off WiFi
    svc wifi disable
else
    # eth0 is not connected, turn on WiFi
    svc wifi enable
fi
```

## Contributing
Feel free to open issues or pull requests if you have any suggestions or improvements.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
