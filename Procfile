web: bundle exec rails server thin -p $PORT
worker: bundle exec rake resque:work QUEUE='dans' VERBOSE=1
cron: bundle exec clockwork app/clock.rb
