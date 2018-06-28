[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

# Upon Arrival

The key information you need to know once you get there.

## Running Locally

TL;DR: Install [docker](https://store.docker.com/editions/community/docker-ce-desktop-mac) & [Yarn](https://yarnpkg.com/lang/en/docs/install/#mac-stable)

We're using [docker-compose](https://docs.docker.com/compose/rails/) to help everyone have the same setup. Navigate over to [The Docker Store](https://store.docker.com/editions/community/docker-ce-desktop-mac) and install docker locally.

For JavaScript & NPM assets, we're using [Yarn](https://yarnpkg.com/lang/en/docs/install/#mac-stable), make sure that's also installed.

## The Site

    git clone git@github.com:sarahball/upon-arrival.git &&
    cd upon-arrival &&
    yarn && 
    docker-compose up

You should be able to access the local version of the site at http://127.0.0.1:3000/.

## Running one off tasks

If you need to run a one off task (Like seeding, or migrations) run them like so:

    docker-compose run --rm web bundle exec rake db:seed
