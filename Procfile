web: bundle exec rails server thin -p $PORT
worker: bundle exec rake resque:work QUEUE='*'
cron: bundle exec clockwork app/clock.rb
