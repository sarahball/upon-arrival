#!/bin/bash

echo "Running Release Tasks"

if [ "$RUN_MIGRATIONS_DURING_RELEASE" == "true" ]; then 
  echo "Running Migrations"
  bundle exec rake db:migrate
fi

if [ "$CLEAR_CACHE_DURING_RELEASE" == "true" ]; then 
  echo "Clearing Rails Cache"
  bundle exec rake deploy:clear_rails_cache
fi

echo "Done"
