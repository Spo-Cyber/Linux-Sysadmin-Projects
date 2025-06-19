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

More coming soon!
