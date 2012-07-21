module ApplicationHelper
  def numerify(text)
    Linguistics::use(:en)
    text.en.numwords
  end
  
  def pricify(dollars = nil)
    return "" if dollars == nil
    return "Free" if dollars == 0
    return "$#{dollars}" if dollars < 1
  end
  
end
