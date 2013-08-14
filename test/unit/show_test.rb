require 'test_helper'

class ShowTest < ActiveSupport::TestCase

  def setup
    @show = FactoryGirl.build :show
  end

  test "should have valid factory" do
    assert @show.valid?, "show factory is not valid"
  end

  test "should have source" do
    @show = FactoryGirl.build :show, source: ""
    assert ! @show.valid?, "show has no source :("
  end

  test "should have starts_at" do
    @show = FactoryGirl.build :show, starts_at: ""
    assert ! @show.valid?, "show has no starts_at :("
  end

  test "should have time_is_unknown" do
    @show = FactoryGirl.build :show, time_is_unknown: nil
    assert ! @show.valid?, "show has no time_is_unknown :("
  end
end
