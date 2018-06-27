#!/bin/bash

# Exit on fail
set -e

echo ""
echo "⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡"
echo "          Upon Arrival - Development Environment"
echo "⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡⚡"

echo ""
echo "Authors: Sarah Ball (@_satelliteeyes) & Mike Rogers (@MikeRogers0)"

# TODO: Do a check to make sure we have all the ENV attributes we need

# Ensure all gems installed. Add binstubs to bin which has been added to PATH in Dockerfile.
# Bundler caching based on: https://medium.com/@jfroom/docker-compose-3-bundler-caching-in-dev-9ca1e49ac441
echo ""
bundle check || bundle install --binstubs="$BUNDLE_BIN"
echo "    👍"

# Removing any old pids from a previous run
rm -f tmp/pids/server.pid

if [[ ${@} = *"bundle exec rails s -p"* ]]; then
 . /docker/full-run.sh 
else
 . /docker/one-off-task.sh 
fi

# Finally call command issued to the docker service
exec "$@"
