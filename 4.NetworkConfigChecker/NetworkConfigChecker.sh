#!/usr/bin/env bash

# NOTE:
# Works best on typical Linux systems using systemd-networkd or NetworkManager.
# Complex or custom setups (VPNs, DNS-over-HTTPS, containers) may not be fully detected.
# Use as a quick baseline network status check, not a comprehensive audit.

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Detect active network interface
intf_name=$(ip route get 1.1.1.1 2>/dev/null | grep -oP "dev\s\K[0-9a-zA-Z]+\s")
intf_name=${intf_name:-"Not Found."}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Get IP address used to reach the internet (via route to 1.1.1.1)
ip_address=$(ip route get 1.1.1.1 2>/dev/null | grep -oP "src\s\K[0-9.]+")
ip_address=${ip_address:-"Not Found."}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Get default gateway
default_gateway=$(ip route | grep -oP "default\svia\s\K[0-9.]+")
default_gateway=${default_gateway:-"Not Found."}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Read DNS servers from /etc/resolv.conf (with %interface removed for IPv6)
dns_servers="Unknown"

if [[ -L /etc/resolv.conf ]]; then
	echo -e "⚠️ /etc/resolv.conf is a symlink (possibly managed by systemd-resolved)\n"
fi

dns_servers=$(grep -oP '^nameserver\s+\K.+' /etc/resolv.conf | sed 's/%.*//g' | tr '\n' ' ')
dns_servers=${dns_servers:-"Not Found."}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Check which network manager is active
is_sysnetd=$(systemctl is-active systemd-networkd 2>/dev/null)
is_netmngrd=$(systemctl is-active NetworkManager 2>/dev/null)

network_manager="Unknown"
if [[ "$is_sysnetd" == "active" && "$is_netmngrd" == "active" ]]; then
	network_manager="❌ Conflict: Both systemd-networkd and NetworkManager are active!"
elif [[ "$is_sysnetd" == "active" ]]; then
	network_manager="systemd-networkd"
elif [[ "$is_netmngrd" == "active" ]]; then
	network_manager="NetworkManager"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Check internet connectivity via ping test
internet_status="Unknown"
if ping -q -c 2 1.1.1.1 >/dev/null; then
	internet_status="Connected"
else
	internet_status="Not Connected"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Current Timestamp
timestamp=$(date "+%F %H:%M")

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Log file location
log_file=~/network_report.log
if [[ ! -f $log_file ]]; then
	touch $log_file
fi

{
	echo "[$timestamp]"
	echo "Interface Name   : $intf_name"
	echo "IP address       : $ip_address"
	echo "Default Gateway  : $default_gateway"
	echo "DNS Servers      : $dns_servers"
	echo "Internet Status  : $internet_status"
	echo "Network Manager  : $network_manager"
	echo "-------------------------------------------------------"
} | tee -a "$log_file"
