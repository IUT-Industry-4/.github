#!/bin/bash

# Log file setup
LOG_FILE="/mnt/D/projects/myGithub/IUT-Industry-4/auto-update.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Change to the project directory
cd /mnt/D/projects/myGithub/IUT-Industry-4

# Log start
echo "[$TIMESTAMP] Starting auto-update process" >>"$LOG_FILE"

# Pull latest changes
echo "[$TIMESTAMP] Pulling from Git..." >>"$LOG_FILE"
git pull origin main >>"$LOG_FILE" 2>&1

# Rebuild and restart Docker containers
echo "[$TIMESTAMP] Rebuilding Docker containers..." >>"$LOG_FILE"
docker compose down >>"$LOG_FILE" 2>&1
docker compose up --build -d >>"$LOG_FILE" 2>&1

# Log completion
echo "[$TIMESTAMP] Auto-update process completed" >>"$LOG_FILE"
echo "----------------------------------------" >>"$LOG_FILE"
