# http://api.openweathermap.org/data/2.5/weather?id=4685907

# class Weather
#   include HTTParty
#   base_uri "api.openweathermap.org"
#   format :json
#   caches_api_responses :key_name => "weather", :expire_in => 3600

#   def self.current
#     self.get("/data/2.5/weather?id=4685907")
#   end
# end