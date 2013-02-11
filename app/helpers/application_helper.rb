# FIXME
module ApplicationHelper
  def numerify(text)
    Linguistics::use(:en)
    word = text.en.numwords
    text.to_s.length == 1 ? word : text
  end

  def pricify(dollars = nil)
    return "$?" if dollars == nil
    return "Free" if dollars == 0
    return "$#{dollars}" if dollars < 1
  end

  def li_active_link_to(text, url)
    if is_active_link?(url, :exclusive)
      content_tag :li, :class => "active" do
        link_to text, url
      end
    else
      content_tag :li do
        link_to text, url
      end
    end
  end

  # content_tag

  # chronic will parse this no problem
  def standard_datetime( data )
    data.strftime('%Y-%m-%d %H:%M')
  end

end
