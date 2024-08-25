# !/bin/bash

# 1. Download der Seite
curl -o page.html https://www.minecraft.net/en-us/download/server/bedrock

# 2. Extrahieren des Links für die ZIP-Datei
zip_url=$(grep -oP 'https://minecraft.azureedge.net/bin-linux/bedrock-server-[0-9\.]+\.zip' page.html | head -1)

if [ -z "$zip_url" ]; then
    echo "Kein Link zur ZIP-Datei gefunden."
    exit 1
fi

echo "Gefundener ZIP-Link: $zip_url"

# 3. Download der ZIP-Datei
curl -o bedrock-server.zip "$zip_url"

# 4. Extrahieren der ZIP-Datei in einen eigenen Ordner
mkdir bedrock-server
unzip -o bedrock-server.zip -d bedrock-server

# 5. Kopieren der Inhalte in den aktuellen Ordner, bestimmte Dateien nicht überschreiben
for file in bedrock-server/*; do
    filename=$(basename "$file")
    if [[ "$filename" != "permissions.json" && "$filename" != "server.properties" && "$filename" != "allowlist.json" ]]; then
       cp -r "$file" .
    else
       echo "$filename wurde nicht überschrieben."
    fi
done

# Bereinigung
rm -r bedrock-server
rm bedrock-server.zip

echo "Vorgang abgeschlossen."
