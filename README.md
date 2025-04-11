# Magisk Modules

This repository contains multiple Magisk modules, each designed for different functional requirements. Each module is located in its own subdirectory.

## Module List

### [Magisk LAN Auto Switch](./magisk-lan-auto-switch/README.md)
Automatically switches between LAN and WiFi based on the connection status of `eth0`.  
- Disables WiFi when `eth0` is connected.
- Enables WiFi when `eth0` is disconnected.

### [Magisk Fake Battery](./magisk-fake-battery/README.md)
Fakes battery status, suitable for devices without a battery.  
- Sets battery level to 100%.
- Mocks charging status and temperature.

### [Magisk Auto ADB](./magisk-auto-adb/README.md)
Automatically starts ADB (Android Debug Bridge) after the device boots.  
- Configures ADB over TCP on port `5555` by default.
- Restarts ADB service to apply the configuration.

### [Magisk Auto Boot on Charger in LPM](./magisk-autoboot-lpm/README.md)
**NOT Recommended**.  
Automatically boots the device when a charger is connected in low-power mode without a battery.  
- Modifies boot behavior to bypass low-power mode.

### [Magisk Override Country Code](./magisk-override-country-code/README.md)
Overrides the device's country code to `CN` or `US`.  
- Sets system properties for country and locale configuration.

### [Magisk Tabletify](./magisk-tabletify/README.md)
Transforms your Android device into tablet mode by modifying system properties.  
- Changes DPI to 240.
- Adjusts screen rotation to 270 degrees.
- Sets device model to `SM-T860` (Samsung tablet).

## Installation
1. Go to the [Release Page](https://github.com/NewFuture/magisk-modules/releases) to download the desired module's zip file.
2. In Magisk Manager, select the "Modules" tab, click "Install Module," and choose the downloaded zip file.
3. Reboot the device to apply the module.

## Contribution
If you have any suggestions or improvements, feel free to submit an Issue or Pull Request.

## License
This project is licensed under the MIT License. For more details, please refer to the [LICENSE](LICENSE) file.

# Magisk 模块

此仓库包含多个 Magisk 模块，分别用于不同的功能需求。每个模块位于其独立的子目录中。

## 模块列表

### [Magisk LAN Auto Switch](./magisk-lan-auto-switch/README.md)
自动根据 `eth0` 的连接状态切换 LAN 和 WiFi。  
- 当 `eth0` 连接时禁用 WiFi。
- 当 `eth0` 断开时启用 WiFi。

### [Magisk Fake Battery](./magisk-fake-battery/README.md)
伪造电池状态，适用于移除电池的设备。  
- 设置电池电量为 100%。
- 模拟充电状态和温度。

### [Magisk Auto ADB](./magisk-auto-adb/README.md)
在设备启动后自动启动 ADB（Android Debug Bridge）。  
- 默认配置 ADB TCP 端口为 `5555`。
- 重启 ADB 服务以应用配置。

### [Magisk Auto Boot on Charger in LPM](./magisk-autoboot-lpm/README.md)
**不推荐(可能无法恢复)**  
在无电池触发低功耗模式下，连接充电器时自动启动设备。  
- 修改启动行为以绕过低功耗模式。

### [Magisk Override Country Code](./magisk-override-country-code/README.md)
覆盖设备的国家代码为 `CN` 或 `US`。  
- 设置系统属性以配置国家和区域设置。

### [Magisk Tabletify](./magisk-tabletify/README.md)
将您的 Android 设备转换为平板模式，通过修改系统属性。  
- 将 DPI 设置为 240。
- 调整屏幕旋转为 270 度。
- 设置设备型号为 `SM-T860`（三星平板）。

## 安装
1. 前往 [Release 页面](https://github.com/NewFuture/magisk-modules/releases) 下载所需模块的压缩包。
2. 在 Magisk Manager 中选择“模块”选项卡，点击“安装模块”，并选择下载的压缩包。
3. 重启设备以应用模块。

## 贡献
如果您有任何建议或改进，请随时提交 Issue 或 Pull Request。

## 许可证
此项目基于 MIT 许可证授权。有关详细信息，请参阅 [LICENSE](LICENSE) 文件。