#!/bin/bash

# Check if a version was passed as a parameter
if [ -z "$1" ]; then
    # No version provided, download the page and determine the version
    echo "No version provided, determining version from the website..."
    curl -o page.html https://www.minecraft.net/en-us/download/server/bedrock

    # Extract the link for the ZIP file
    zip_url=$(grep -oP 'https://minecraft.azureedge.net/bin-linux/bedrock-server-[0-9\.]+\.zip' page.html | head -1)

    if [ -z "$zip_url" ]; then
        echo "No ZIP file link found."
        exit 1
    fi

    echo "Found ZIP link: $zip_url"
else
    # Version was provided, construct the download link
    version="$1"
    zip_url="https://minecraft.azureedge.net/bin-linux/bedrock-server-${version}.zip"
    echo "Using provided version: $version"
    echo "ZIP link: $zip_url"
fi

# 3. Download the ZIP file
curl -o bedrock-server.zip "$zip_url"

# 4. Extract the ZIP file into a dedicated folder
mkdir bedrock-server
unzip -o bedrock-server.zip -d bedrock-server

# 5. Copy the contents to the current directory, do not overwrite certain files
for file in bedrock-server/*; do
    filename=$(basename "$file")
    if [[ "$filename" != "permissions.json" && "$filename" != "server.properties" && "$filename" != "allowlist.json" ]]; then
       cp -r "$file" .
    else
       echo "$filename was not overwritten."
    fi
done

# Cleanup
rm -r bedrock-server
rm bedrock-server.zip

echo "Update completed."
