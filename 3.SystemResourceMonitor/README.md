# 🖥️  System Resource Monitor Script

This Bash script monitors your system's **CPU**, **RAM**, and **Disk** usage. It logs resource statistics with timestamps and shows a warning if usage exceeds critical thresholds. It's ideal for server admins, sysadmins, or Linux learners who want to track system health.

---

## 📌 Features

- ✅ Tracks CPU, RAM, and Disk usage
- ✅ Logs usage to `resource_usage.log` with timestamps
- ✅ Alerts if usage exceeds **80%**
- ✅ Uses color-coded terminal output
- ✅ Can be run manually or scheduled with cron

---

## 🛠️ How It Works

- **CPU Usage:** Calculated as `100 - %idle` using `mpstat`
- **RAM Usage:** Calculated from `free` output as `(used/total) * 100`
- **Disk Usage:** Root partition (`/`) usage from `df`

If any of the values go above **80%**, a red ⚠️ warning is logged. Otherwise, a green ✅ status is recorded.

---

## 🧪 Example Output

2025-06-20 22:40 CPU: 35% | RAM: 47% | Disk: 51% - ✅ Normal
2025-06-20 22:45 CPU: 91% | RAM: 85% | Disk: 89% - ⚠️  WARNING: High usage!

---

## 🚀 Usage
1. Make the script executable
chmod +x monitor.sh

2. Run the script
./monitor.sh

---
## ⏰ Optional: Run with Cron
To monitor your system every 5 minutes:

crontab -e
*/5 * * * * /full/path/to/SysResourceMonitor.sh
