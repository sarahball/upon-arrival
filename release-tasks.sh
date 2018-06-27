#!/bin/bash

echo "Running Release Tasks"

if [ "$DURING_RELEASE_RUN_MIGRATIONS" == "true" ]; then 
  echo "Running Migrations"
  bundle exec rails db:migrate
fi

if [ "$DURING_RELEASE_CLEAR_CACHE" == "true" ]; then 
  echo "Clearing Rails Cache"
  bundle exec rails r "Rails.cache.clear"
fi

if [ "$DURING_RELEASE_SEED_DB" == "true" ]; then 
  echo "Seeding DB"
  #bundle exec rails db:seed
fi

echo "Done"
