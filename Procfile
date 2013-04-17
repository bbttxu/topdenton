web: bundle exec rails server thin -p $PORT
worker: bundle exec rake resque:work QUEUE='*' VERBOSE=0
cron: bundle exec clockwork app/clock.rb
