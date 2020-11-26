#!/usr/bin/env bash

LOG_FOLDER="${LOG_FOLDER:-/var/log/gunicorn}"
REQUIREMENTS_FILE="${REQUIREMENTS_FILE:-/srv/requirements.txt}"

if [ -f "/started_at.txt" ]; then
    echo "Restarting container..."
else
  echo "Starting container..."
  # Create the log folder and assign the right permission.
  mkdir -p "$LOG_FOLDER"
  chown www:www -R "$LOG_FOLDER"
  # Install python dependencies.
  if [ -f "$REQUIREMENTS_FILE" ]; then
    if ! pip install --progress-bar off -r "$REQUIREMENTS_FILE"; then
      exit 1
    fi
  fi
  # Save the starting time of the container.
  date > /started_at.txt
fi

# Launch Gunicorn with the log saved into the folder and standard output.
su www -c "(gunicorn --bind=0.0.0.0:8000 --access-logfile=- --error-logfile=- --workers=\"$NBR_WORKER\" \"$APP_MODULE\" | tee \"$LOG_FOLDER/access.log\") 3>&1 1>&2 2>&3 | tee \"$LOG_FOLDER/error.log\""
