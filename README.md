# 🧰 Linux System Administration Projects

This repository contains practical Bash scripting and Linux sysadmin projects I created as a junior system administrator to automate real-world tasks and demonstrate my skills.

## 📂 Projects Included

### 1. BackupWithLogging
- Backs up any file or folder as a `.tar.gz` archive.
- Logs success or failure with timestamps.
- Supports automation via `cron`.

### 2. UserAccountAutomation
- Interactive script to create new Linux users.
- Automatically sets:
  - Home directory
  - Default shell (`/usr/bin/bash`)
  - Initial password to `"changeme"`
  - Forces password change on first login for security
- Logs all actions with timestamps to `~/UserAccountLogs.log` in the invoking user’s home directory.
- Must be run with `sudo` to have the necessary permissions.

### 3. SystemResourceMonitor
- Monitors **CPU**, **RAM**, and **Disk** usage in real time.
- Logs usage information to `resource_usage.log` with timestamps.
- Displays color-coded terminal output for easy status recognition.
- Alerts when any resource exceeds **80%** usage.
- Uses `mpstat`, `free`, and `df` for accurate system insights.
- Can be scheduled with `cron` for automated monitoring.

### 4. NetworkConfigChecker
- Checks and logs key Linux network configuration details.
- Displays:
  - Active network interface
  - IP address and default gateway
  - DNS servers (cleans up IPv6 scope suffixes)
  - Internet connectivity status
  - Active network manager (e.g., `systemd-networkd` or `NetworkManager`)
- Warns if both network managers are active (conflict).
- Logs output to `network_report.log` with timestamps.
- Suitable for quick diagnostics or scheduled logging via `cron`.

More coming soon!
