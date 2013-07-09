# rubbergloves_test.rb
require 'test_helper'

class RubberGlovesRecordingStudioTest < ActiveSupport::TestCase
  def setup
    stub_request(:any, "www.example.com")
    VCR.use_cassette('rgrs_calendar') do
      @rgrs = open( 'http://rubberglovesdentontx.com/calendar/' )
    end
    @html = Nokogiri::HTML( @rgrs )
  end

  test "the rgrs response has shows" do
    assert @html.css('#calendar article.show'), "getting RGRS was not 200"
  end
end
