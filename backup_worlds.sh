#!/bin/bash

# Paths relative to the directory where the script is executed
WORLDS_DIR="./worlds"
BACKUP_DIR="./backups"

# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"

# Timestamp in the format Year-Month-Day_Hour-Minute-Second
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Iterate through all worlds in the worlds directory
for WORLD in "$WORLDS_DIR"/*; do
  if [ -d "$WORLD" ]; then
    WORLD_NAME=$(basename "$WORLD")
    BACKUP_FILE="$BACKUP_DIR/${WORLD_NAME}_backup_$TIMESTAMP.tar.gz"

    # Create a tar.gz backup of the world
    tar -czf "$BACKUP_FILE" -C "$WORLDS_DIR" "$WORLD_NAME"

    echo "Backup created for $WORLD_NAME: $BACKUP_FILE"
  fi
done
