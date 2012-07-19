
class String
  def initial
    self[0,1]
  end
end

module ShowsHelper
  def do_time(timestamp)
    meridian = Time.at(timestamp).strftime("%p")
    time = Time.at(timestamp).strftime("%I:%M")
    time = Time.at(timestamp).strftime("%I") if Time.at(timestamp).strftime("%M") == "00"

    "#{time}#{meridian.initial}"
  end
  
end
