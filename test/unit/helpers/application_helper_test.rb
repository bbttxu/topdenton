require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def test_on_day_or_night

    date = Time.new(2013, 8, 5, 12, 0, 0)

    assert_equal day_or_night(date), "day"
    assert_equal day_or_night(date + 12.hours), "night"
  end
end
