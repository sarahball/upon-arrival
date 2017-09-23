[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

# Upon Arrival

The key information you need to know once you get there.

## Running Locally

Copy and paste the below command and you should be good to go!

### Services and Libraries

    gem install foreman &&
    gem install middleman &&
    gem install powder

### Puma Dev Server

Follow the instructions found [in this gist](https://gist.github.com/MikeRogers0/5d3eceb38bae7b662476778f1d8d29cc) to migrate from Pow to Puma Dev & enabling https locally.

## The Marketing Site

    git clone git@github.com:sarahball/upon-arrival.git &&
    cd upon-arrival &&
    bundle &&
    puma-dev link &&
    powder open

You should be able to access the local version of the site at https://upon-arrival.localhost/.
