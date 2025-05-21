#!/bin/bash

# Function to extract package removing comments
extract_brewfile_packages() {
    local file=$1
    grep -v '^#' "$file" | grep -v '^$' | sed 's/^[[:space:]]*//' | sed 's/#.*$//' | sed 's/[[:space:]]*$//' | tr -s ' '
}

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define file paths
BREWFILE_AUTO="$SCRIPT_DIR/Brewfile.auto"
BREWFILE_MANUAL="$SCRIPT_DIR/Brewfile.manual"

# Check if files exist
if [ ! -f "$BREWFILE_AUTO" ]; then
    echo "Error: Brewfile.auto not found at $BREWFILE_AUTO"
    exit 1
fi

if [ ! -f "$BREWFILE_MANUAL" ]; then
    echo "Error: Brewfile.manual not found at $BREWFILE_MANUAL"
    exit 1
fi

# Extract packages from both files
packages_auto=$(extract_brewfile_packages "$BREWFILE_AUTO")
packages_manual=$(extract_brewfile_packages "$BREWFILE_MANUAL")

# Find packages unique to each file
unique_to_auto=$(comm -23 <(echo "$packages_auto" | sort) <(echo "$packages_manual" | sort))
unique_to_manual=$(comm -13 <(echo "$packages_auto" | sort) <(echo "$packages_manual" | sort))

# Print results
if [ ! -z "$unique_to_auto" ]; then
    echo "Packages that could potentially be in Brewfile.manual"
    echo "$unique_to_auto"
fi

if [ ! -z "$unique_to_manual" ]; then
    if [ ! -z "$unique_to_auto" ]; then
        echo -e "\n"
    fi
    echo "Packages in Brewfile.manual that are not in Brewfile.auto"
    echo "$unique_to_manual"
fi 
