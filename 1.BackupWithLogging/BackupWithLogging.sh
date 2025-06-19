#!/usr/bin/env bash

# Directory , where the backup files will be saved
backup_dir="$HOME/backups"
mkdir -p $backup_dir

# Log file , where the logs of backup processes will be saved
backup_log="$backup_dir/backup.log"
touch $backup_log

# Date and time for specifying the backup file's timestamp
date_time=$(date '+%F_%H:%M')

# Prompt for a file as much , as the user enters invalid path
while :
do
	# Date and time for specifying the backup file's timestamp
	date_time=$(date '+%F_%H:%M')

	read -p "What is the absolute path of a file or a directory to backup? " filedirpath

	# If the file or directory exists then process, if not then Invalid path ERROR
	if [[ -f "$filedirpath" || -d "$filedirpath" ]]; then
		echo "Creating a backup file..."
		
		# Naming the backup file
		backup_path="$backup_dir/backup_${date_time}.tar.gz"

		sleep 1
		result_message="The backup of $filedirpath has been created successfully."

		# Creating tar archive with gzip compression for the file
		tar -czvf "$backup_path" -C "$(dirname $filedirpath)" "$(basename $filedirpath)" 
		
		if [[ $? -eq 0 ]]; then 
			echo "$result_message"
			ls -l "$backup_dir" | grep "backup_${date_time}.tar.gz" --color="always"

			# Logging about successful backup result
			echo "[$date_time] SUCCESS: $result_message" >> $backup_log
		else
			echo "Error, while creating a backup file!"
			
			# Logging about unseccessful backup result
			echo "[$date_time] ERROR: while backing up the $filedirpath." >> $backup_log
		fi
		break
	else
		echo "Invalid path.Try again!"

		# Logging about unseccessful backup result
		echo "[$date_time] ERROR: Invalid file or directory: $filedirpath" >> $backup_log
	fi
done


# To make this script run for a default path to backup with cron
# Instead of << read -p "What is the path... >> , just set filedirpath=/default/path
# crontab -e => 0 2 * * * /home/username/BackupWithLogging.sh
