require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  def setup
    @artist = FactoryGirl.build :artist
  end

  test "should have name" do
    assert ! @artist.name.empty?
  end
end
