#!/bin/bash

# Setup script for dbt-keboola-snowflake project
# This script creates/updates a conda environment based on .env configuration

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located (relative path)
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
cd "$SCRIPT_DIR"

echo -e "${GREEN}🚀 Setting up dbt-keboola-snowflake environment...${NC}"

# Check if .env file exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}⚠️  .env file not found. Creating from .env.example...${NC}"
    if [ -f .env.example ]; then
        cp .env.example .env
        echo -e "${GREEN}✅ Created .env file from .env.example${NC}"
        echo -e "${YELLOW}⚠️  Please edit .env file with your actual values before continuing!${NC}"
        echo -e "${YELLOW}   Press Enter to continue or Ctrl+C to abort...${NC}"
        read
    else
        echo -e "${RED}❌ Error: .env.example not found. Cannot create .env file.${NC}"
        exit 1
    fi
fi

# Source .env file
echo -e "${GREEN}📖 Loading environment variables from .env...${NC}"
set -a  # Automatically export all variables
source .env
set +a

# Validate required variables
REQUIRED_VARS=("PYTHON_VERSION" "CONDA_ENV_PATH")
MISSING_VARS=()

for var in "${REQUIRED_VARS[@]}"; do
    if [ -z "${!var}" ]; then
        MISSING_VARS+=("$var")
    fi
done

if [ ${#MISSING_VARS[@]} -ne 0 ]; then
    echo -e "${RED}❌ Error: Missing required environment variables:${NC}"
    printf '%s\n' "${MISSING_VARS[@]}"
    exit 1
fi

# Use relative path for conda environment
CONDA_ENV_REL_PATH="$CONDA_ENV_PATH"

echo -e "${GREEN}🐍 Creating/updating conda environment with Python ${PYTHON_VERSION}...${NC}"
echo -e "${GREEN}   Environment path: ${CONDA_ENV_REL_PATH}${NC}"

# Create or update conda environment
# Include openssl and certifi for SSL support (needed for pip to work with HTTPS)
# Check if environment exists by checking if the directory exists
if [ -d "$CONDA_ENV_REL_PATH" ] && [ -f "$CONDA_ENV_REL_PATH/bin/python" ]; then
    echo -e "${YELLOW}⚠️  Conda environment already exists. Updating...${NC}"
    conda install -p "$CONDA_ENV_REL_PATH" python="$PYTHON_VERSION" pip openssl certifi -y
else
    echo -e "${GREEN}✨ Creating new conda environment...${NC}"
    conda create -p "$CONDA_ENV_REL_PATH" python="$PYTHON_VERSION" pip openssl certifi -y
fi

# Get the Python and pip paths (using relative paths)
PYTHON_BIN="$CONDA_ENV_REL_PATH/bin/python"
PIP_BIN="$CONDA_ENV_REL_PATH/bin/pip"

# Verify Python version
INSTALLED_VERSION=$("$PYTHON_BIN" --version 2>&1 | awk '{print $2}')
echo -e "${GREEN}✅ Python ${INSTALLED_VERSION} installed${NC}"

# Ensure pip is available (install via ensurepip if conda didn't install it)
if [ ! -f "$PIP_BIN" ]; then
    echo -e "${YELLOW}⚠️  pip not found, installing via ensurepip...${NC}"
    "$PYTHON_BIN" -m ensurepip --upgrade
fi

# Upgrade pip
echo -e "${GREEN}📦 Upgrading pip...${NC}"
"$PIP_BIN" install --upgrade pip --quiet

# Install dbt-keboola-snowflake
echo -e "${GREEN}📦 Installing dbt-keboola-snowflake from GitHub...${NC}"
"$PIP_BIN" install git+https://github.com/keboola-rnd/dbt-keboola-snowflake.git

# Install additional requirements if specified
if [ -n "$REQUIREMENTS_FILE" ] && [ -f "$REQUIREMENTS_FILE" ]; then
    echo -e "${GREEN}📦 Installing additional requirements from $REQUIREMENTS_FILE...${NC}"
    "$PIP_BIN" install -r "$REQUIREMENTS_FILE"
elif [ -f "requirements.txt" ]; then
    echo -e "${GREEN}📦 Installing additional requirements from requirements.txt...${NC}"
    "$PIP_BIN" install -r requirements.txt
fi

# Verify installation
echo -e "${GREEN}🔍 Verifying installation...${NC}"
"$PIP_BIN" list | grep -E "(dbt|keboola)" || true

echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo -e "${GREEN}To activate the environment, run:${NC}"
echo -e "  ${YELLOW}conda activate \"$CONDA_ENV_REL_PATH\"${NC}"
echo ""
echo -e "${GREEN}Or use Python directly:${NC}"
echo -e "  ${YELLOW}\"$PYTHON_BIN\" -m dbt --version${NC}"
echo ""

