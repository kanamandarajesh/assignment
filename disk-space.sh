#!/bin/bash

# Default threshold (40 hours)
threshold=144000

# Get threshold from argument (if provided)
if [[ ! -z "$1" ]]; then
  # Ensure time is specified in hours
  if [[ ! "$1" =~ ^[0-9]+h$ ]]; then
    echo "Invalid argument: Please specify time in hours (e.g., 10h)"
    exit 1
  fi
  threshold=$(( $(echo "$1" | cut -d h -f1) * 3600 ))
fi

# Get current timestamp (UTC)
now=$(date +%Y-%m-%dT%H:%M:%SZ)

# Log file name
logfile="deleted-files-$(date +%d-%m-%Y).log"

# Loop through .wav files in /data/audios/
find /data/audios/ -name "*.wav" -type f | while read -r file; do

  # Get file creation time in seconds since epoch (UTC)
  file_time=$(stat -c %X "$file")

  # Calculate age difference in seconds
  age=$(( $now - $file_time ))

  # Check if file is older than threshold
  if [[ $age -ge $threshold ]]; then

    # Get file creation time in ISO format (with local timezone)
    creation_time=$(stat -c %y "$file" | sed 's/\..*//')

    # Delete the file
    rm -f "$file"

    # Log deletion with creation and deletion times (ISO format)
    echo "$file $creation_time $now" >> "$logfile"

    echo "Deleted: $file (age: $((age / 3600))h)"
  fi
done

echo "Disk cleanup completed. Check log file: $logfile"
