# 🔐 Linux User Creation Script

This Bash script automates the process of creating new Linux user accounts with a default configuration. 
It's designed for system administrators to quickly and securely add users with initial settings, logging every action taken.

---

## ✅ Features

- Prompts for a new username interactively
- Creates:
  - Home directory (`/home/username`)
  - Default shell (`/usr/bin/bash`)
  - Default comment field
- Sets an initial password: `changeme`
- Forces password change on first login
- Logs all actions with timestamps to a log file
- Prevents duplicate user creation
- Validates user input
- Provides error handling and retry support

---

## 📋 Requirements

- Must be run with `sudo` (root privileges)
- Bash shell environment (shebang: `#!/usr/bin/env bash`)

---

## 🛠 Usage

1. Save the script file, for example as `CreateUser.sh`.

2. Make the script executable:
   ```bash
   chmod +x CreateUser.sh
