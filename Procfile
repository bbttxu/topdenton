web: bundle exec rails server thin
worker: bundle exec rake resque:work QUEUE='*'
cron: bundle exec clockwork app/clock.rb
testing: bundle exec autotest
