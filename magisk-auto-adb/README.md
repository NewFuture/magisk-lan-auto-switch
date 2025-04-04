# ADB Auto-Start Magisk Module

This Magisk module automatically starts ADB (Android Debug Bridge) after the device boots. It ensures that ADB over the network is enabled or configured based on the system's current settings.

## Features
- Automatically starts ADB after boot.
- Checks if `persist.adb.tcp.port` is configured:
  - If not configured, sets it to `5555` (default port for ADB over TCP).
  - If already configured, uses the existing configuration.
- Restarts the ADB service to apply the configuration.
