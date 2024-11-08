# Backup Files Older Than 10 Days, Zip the Directory, and Include Date-Time Stamp

#!/bin/bash

# Define source directory
SOURCE_DIR="/path/to/source"  # Replace with your source directory

# Define backup root directory
BACKUP_ROOT_DIR="/path/to/backup"  # Replace with your main backup directory

# Create a backup directory with current date and time
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$BACKUP_ROOT_DIR/backup_$DATE"
mkdir -p "$BACKUP_DIR"

# Find files older than 10 days and move them to the new backup directory
find "$SOURCE_DIR" -type f -mtime +10 -exec mv {} "$BACKUP_DIR" \;

# Zip the backup directory
ZIP_FILE="$BACKUP_ROOT_DIR/backup_$DATE.zip"
zip -r "$ZIP_FILE" "$BACKUP_DIR"

# Remove the unzipped backup directory after zipping
rm -rf "$BACKUP_DIR"

echo "Backup completed and zipped at $ZIP_FILE."