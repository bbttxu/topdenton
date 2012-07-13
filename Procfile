web: rails server
worker: rake resque:work QUEUE='*'
cron: bundle exec clockwork app/clock.rb