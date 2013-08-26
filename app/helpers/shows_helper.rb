# provide a convenience method to get the intial character of a string (and the explanatory comment is longer than the code itself)
class String
  def initial
    self[0,1]
  end
end

module ShowsHelper
  def do_time(timestamp)
    timeistamp= Time.zone.at(timestamp.to_i)
    meridian = timestamp.strftime("%p")
    time = timestamp.strftime("%I:%M")
    time = timestamp.strftime("%I") if Time.zone.at(timestamp).strftime("%M") == "00"
    "#{time}#{meridian.initial}"
  end


  def format_show_day(timestamp)
    the_time = Time.zone.at(timestamp)
    long_day = the_time.strftime( "%A" )
    short_day = the_time.strftime( "%a" )
    awesome_day = long_day.gsub(short_day, "")

    "#{short_day}<span>#{awesome_day}</span>".html_safe
  end

  def format_show_month(timestamp)
    the_time = Time.zone.at(timestamp)
    long_month = the_time.strftime( "%B" )
    short_month = the_time.strftime( "%b" )
    awesome_month = long_month.gsub(short_month, "")

    "#{short_month}<span>#{awesome_month}</span>".html_safe
  end

  def format_show_date(timestamp)
    the_time = Time.zone.at(timestamp )

    "#{the_time.strftime('%d')}".html_safe
  end

end

