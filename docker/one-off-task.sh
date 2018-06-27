#!/bin/bash

# Wait for postgres to start before starting the rest of the service
echo ""
echo "Waiting for the database server to wake up:"
until nc -z "db" 5432; do
  sleep 1
done
echo "    👍"

# Tell the world we're ready to roll
echo ""
echo ""
echo "🚂💨💨  Running your one off task 💨💨"
echo ""
echo ""
