# Magisk DDNS Go

This Magisk module integrates ddns-go to provide Dynamic DNS (DDNS) functionality on Android devices with Magisk.

## Features

- Automatically runs ddns-go service after boot for public IP dynamic DNS.
- Supports custom configuration via `config.yaml`.
- Log and process management for easy debugging and maintenance.

## Installation

1. Download `magisk-ddns-go.zip` from the [Releases](https://github.com/NewFuture/magisk-modules/releases) page.
2. In the Magisk app, go to "Modules" and tap "Install from storage", then select the downloaded zip file.
3. Reboot your device.

## Usage

- The configuration file is located at `config.yaml` in the module directory. 
- The service startup script is [`server.sh`](server.sh), and you can check logs for status.
- The binary is installed at `/vendor/bin/ddns` and runs ddns-go.

## Logs

To view ddns-go logs:

```sh
cat /data/log/ddns-go.log
```

Or use logcat to view module logs:

```sh
logcat -s Magisk
```

## Process Management

- Start/stop ddns-go using the [`action.sh`](action.sh) script.

- run `ddns` in the shell to ddns-go service manually

---

# Magisk DDNS Go

本模块通过集成 ddns-go 实现动态域名解析（DDNS）功能，适用于 Magisk 环境下的 Android 设备。

## 功能特性

- 启动后自动运行 ddns-go 服务，实现公网 IP 动态解析。
- 支持配置文件自定义（config.yaml）。
- 日志与进程管理，便于调试和维护。

## 安装方法

1. 前往 [Releases](https://github.com/NewFuture/magisk-modules/releases) 页面下载 `magisk-ddns-go.zip`。
2. 在 Magisk App 中选择“模块”，点击“从存储安装”，选择下载的 zip 文件。
3. 重启设备。

## 使用说明

- 配置文件位于模块目录下的 `config.yaml`
- 服务启动脚本为 [`server.sh`](server.sh)，可通过日志查看运行状态。
- 二进制文件安装在 `/vendor/bin/ddns`，实际运行时调用 ddns-go。

## 日志查看

可通过如下命令查看 ddns-go 日志：

```sh
cat /data/log/ddns-go.log
```

或使用 logcat 查看模块日志：

```sh
logcat -s Magisk
```

## 进程管理

- 启动/停止 ddns-go 可通过 [`action.sh`](action.sh) 脚本实现。
- 在 shell 中运行 `ddns` 命令手动启动 ddns 服务。