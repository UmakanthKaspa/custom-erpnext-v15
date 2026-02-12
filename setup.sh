#!/bin/bash
set -e

echo "============================================"
echo "  ERPNext v15 + Healthcare + Payments Setup"
echo "============================================"
echo ""

# Check Docker is installed
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed."
    echo "Install it from: https://www.docker.com/products/docker-desktop/"
    exit 1
fi

# Check Docker is running
if ! docker info &> /dev/null; then
    echo "ERROR: Docker is installed but not running."
    echo "Please start Docker Desktop and try again."
    exit 1
fi

# Check if .env already exists
if [ -f .env ]; then
    echo ".env file already exists."
    read -p "Overwrite it? (y/N): " overwrite
    if [[ ! "$overwrite" =~ ^[Yy]$ ]]; then
        echo "Keeping existing .env. Starting containers..."
        docker compose up -d
        echo ""
        echo "Done! Open http://localhost:3000"
        exit 0
    fi
fi

# Ask for passwords
echo "Set your passwords (these are stored locally in .env):"
echo ""
read -sp "Database password [default: admin]: " db_pass
echo ""
read -sp "Admin login password [default: admin]: " admin_pass
echo ""
echo ""

# Use defaults if empty
db_pass=${db_pass:-admin}
admin_pass=${admin_pass:-admin}

# Create .env
cat > .env << EOF
# ERPNext v15 + Healthcare + Payments
DB_PASSWORD=$db_pass
ADMIN_PASSWORD=$admin_pass
EOF

echo ".env file created."
echo ""
echo "Starting ERPNext..."
docker compose up -d

echo ""
echo "============================================"
echo "  Setup complete!"
echo "============================================"
echo ""
echo "  Wait 3-5 minutes for first-time setup."
echo "  Then open: http://localhost:3000"
echo ""
echo "  Login:    Administrator"
echo "  Password: (the admin password you just set)"
echo ""
echo "  Check progress: docker compose logs -f create-site"
echo "============================================"
