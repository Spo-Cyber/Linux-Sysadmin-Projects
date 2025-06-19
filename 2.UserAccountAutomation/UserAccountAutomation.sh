#!/usr/bin/env bash

# --------------------------------------------
# This script creates a new Linux user with:
# - Home directory
# - Default shell
# - Initial password ("changeme")
# - Forced password change at first login
#
# All actions are logged with timestamps to
# ~/UserAccountLogs.log of the user running the script.
# Must be run with sudo.
# --------------------------------------------


while :
do
	# Creating a timestamp for the log file
	time_date=$(date '+%F_%H:%M')

	# If not running the script with sudo, log the error and exit
	if [[ -z $SUDO_USER ]]; then
		logfile="/tmp/UserAccountLogs.log"
		errmessage="Please run this script with 'sudo'."
		echo "$errmessage"
		echo "[$time_date] ${errmessage}" >> "$logfile"
		exit 1
	fi
	
	# Since the script is run with sudo, the EUID is root - get the real user's home directory
	user_home=$(getent passwd "$SUDO_USER" | cut -d: -f6)

	# Create log file if it doesn't exist
	logfile="$user_home/UserAccountLogs.log"
	if [[ ! -f "$logfile" ]]; then
		touch "$logfile" 
	fi

	# Prompt for the new user
	read -r -p "Enter a username to create (or leave blank to retry): " username
	
	# If no username was entered, log an error and retry
	if [[ -z "$username" ]]; then
		errmessage="ERROR: Enter a name for user."
		echo "$errmessage"
		echo "[$time_date] ${errmessage}" >> "$logfile"
		continue
	fi

	# If the username is available (does not exist), proceed with user creation
	if ! id "$username" &>/dev/null; then

		# Inform the user and pause briefly
		echo "Creating the user \"${username}\"..."
		sleep 1
		
		useradd -m -s /usr/bin/bash -c "User Created By Automation Script" "$username"
		if [[ $? -eq 0 ]]; then
			message="The user \"$username\" has been created successfully."
			echo "$message"
			echo "Your default password is 'changeme', which will be expired after the first login."
			
			# Set an initial password for the user
			echo "$username":"changeme" | chpasswd

			# If setting the password failed, log an error and retry
			if [[ $? -ne 0 ]]; then
				echo "[$time_date] ERROR: Failed to set password for $username" >> "$logfile"
				echo "ERROR: Failed to set password!"
				continue
			fi

			# Force the user to change the password on first login
			chage -d 0 "$username"
			
			# Log successful user creation
			echo "[$time_date] SUCCESS: $message" >> "$logfile"

			# Exit the loop (script is complete)
			break
		else
			# If user creation failed, log the error and retry
			errmessage="ERROR: There was an error, while creating the user $username!"
			echo "$errmessage"
			echo "[$time_date] $errmessage" >> "$logfile"
			continue
		fi
	else
		# If the username already exists, log an error and retry
		errmessage="ERROR: There is a user with name \"$username\".Try another username!"
		echo "$errmessage"
		echo "[$time_date] $errmessage" >> "$logfile"
	fi
done
