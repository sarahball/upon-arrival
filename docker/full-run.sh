#!/bin/bash

# Yarn should all installed, but just in case
echo ""
echo "Checking Yarn dependencies are all installed:"
$HOME/.yarn/bin/yarn install --pure-lockfile | sed "s/^/    /g"

# Wait for postgres to start before starting the rest of the service
echo ""
echo "Waiting for the database server to wake up:"
until nc -z "db" 5432; do
  sleep 1
done
echo "    👍"

# We can connect to the DB, lets run migrations as part of the build process.
echo ""
echo "Checking the database has been created and migrated:"
bundle exec rails db:create 2> >(sed "s/^/    /g")
bundle exec rails db:migrate  2> >(sed "s/^/    /g")

# Tell the world we're ready to roll
echo ""
echo ""
echo "✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨"
echo "   🚢  Started Upon Arrival at: http://0.0.0.0:${PORT}/  🚀"
echo "✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨"
echo ""
echo ""
