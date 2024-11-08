#!/bin/bash

# Backup Files Older Than 10 Days, Zip, Upload to S3, and Delete Local Zip
# Define source directory
SOURCE_DIR="/path/to/source"  # Replace with your source directory

# Define backup root directory
BACKUP_ROOT_DIR="/path/to/backup"  # Replace with your main backup directory

# Define S3 bucket name
S3_BUCKET="s3://your-bucket-name"  # Replace with your S3 bucket name

# Create a backup directory with current date and time
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$BACKUP_ROOT_DIR/backup_$DATE"
mkdir -p "$BACKUP_DIR"

# Find files older than 10 days and move them to the new backup directory
find "$SOURCE_DIR" -type f -mtime +10 -exec mv {} "$BACKUP_DIR" \;
# Zip the backup directory
ZIP_FILE="$BACKUP_ROOT_DIR/backup_$DATE.zip"
zip -r "$ZIP_FILE" "$BACKUP_DIR"

# Upload the zip file to the S3 bucket
aws s3 cp "$ZIP_FILE" "$S3_BUCKET/"

# Delete the local zip file after uploading to S3
rm -f "$ZIP_FILE"

# Remove the unzipped backup directory after zipping
rm -rf "$BACKUP_DIR"

echo "Backup completed, zipped, uploaded to S3, and local files cleaned up." 