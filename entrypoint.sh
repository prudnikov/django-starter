#!/usr/bin/env bash

#python /app/src/manage.py migrate --no-input
#python manage.py collectstatic --no-input

# Start Gunicorn processes
echo Starting Gunicorn.

# 44.203.7.126 NGINX Public IP
gunicorn config.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 1
