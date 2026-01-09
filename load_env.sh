#!/bin/bash

# Simple script to load environment variables from .env file
# Usage: source load_env.sh
#    or: . load_env.sh

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

# Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found at $ENV_FILE" >&2
    return 1 2>/dev/null || exit 1
fi

# Load environment variables
set -a  # Automatically export all variables
source "$ENV_FILE"
set +a  # Turn off automatic export

echo "✓ Loaded environment variables from .env"

