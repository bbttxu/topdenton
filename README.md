[![Build Status](https://travis-ci.org/bbttxu/topdenton.svg?branch=master)](https://travis-ci.org/bbttxu/topdenton) [![Coverage Status](https://coveralls.io/repos/bbttxu/topdenton/badge.png?branch=master)](https://coveralls.io/r/bbttxu/topdenton?branch=master)

### getting started

install rbenv, ruby-build, redis and mongodb

environmental variables are stored in config/application.yml

    CONSUMER_KEY: twitter_key
    CONSUMER_SECRET: twitter_secret

Sign up for a twitter api key at https://dev.twitter.com/apps


### development

in a terminal, run:

    bundle exec guard

which will automatically run a number of tasks as code changes.


### Running the app

The app comprises three components; web, cron and background jobs. These can all be run with:

    foreman start

If you only need the web component, use:

    foreman start web
