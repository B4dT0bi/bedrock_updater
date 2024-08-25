#!/bin/bash

# Pfade anpassen
WORLDS_DIR="/pfad/zu/worlds"
BACKUP_DIR="/pfad/zu/backups"

# Sicherstellen, dass das Backup-Verzeichnis existiert
mkdir -p "$BACKUP_DIR"

# Zeitstempel im Format Jahr-Monat-Tag_Stunde-Minute-Sekunde
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Durch alle Welten im worlds-Verzeichnis iterieren
for WORLD in "$WORLDS_DIR"/*; do
  if [ -d "$WORLD" ]; then
    WORLD_NAME=$(basename "$WORLD")
    BACKUP_FILE="$BACKUP_DIR/${WORLD_NAME}_backup_$TIMESTAMP.tar.gz"

    # Welt als tar.gz sichern
    tar -czf "$BACKUP_FILE" -C "$WORLDS_DIR" "$WORLD_NAME"

    echo "Sicherung für $WORLD_NAME erstellt: $BACKUP_FILE"
  fi
done
