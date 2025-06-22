# 🌐 Network Configuration Reporter

This Bash script checks and logs essential Linux network information such as IP address, default gateway, DNS servers, network manager status, and internet connectivity. It is ideal for junior system administrators who want to audit network status quickly and log results for review.

---

## 📌 Features

- ✅ Detects active network interface and its IP address  
- ✅ Shows default gateway and DNS server list  
- ✅ Warns if both `systemd-networkd` and `NetworkManager` are active  
- ✅ Checks internet connectivity with `ping`  
- ✅ Logs output to `network_report.log` with timestamps  
- ✅ Works well on most systemd-based Linux distributions

---

## 🔧 How It Works

- **IP Address & Interface**: Extracted using `ip route get`
- **Default Gateway**: Parsed from `ip route`
- **DNS Servers**: Read from `/etc/resolv.conf`, removes IPv6 scope tags
- **Network Manager**: Checks if `systemd-networkd` or `NetworkManager` is active
- **Internet Test**: Pings `1.1.1.1` to verify connectivity

---

## 📄 Sample Output

[2025-06-22 15:10]
Interface Name : wlan0
IP Address : 192.168.1.42
Default Gateway : 192.168.1.1
DNS Servers : 8.8.8.8 1.1.1.1
Internet Status : Connected
Network Manager : NetworkManager

---

## 🚀 Usage

1. Make the script executable:

   chmod +x NetworkConfigCheck.sh

2. Run the script:
   ./NetworkConfigCheck.sh

---

⏰ Optional: Run Periodically with Cron
To check and log network status every hour:

crontab -e
0 * * * * /full/path/to/NetworkConfigCheck.sh
