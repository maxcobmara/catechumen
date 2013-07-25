require 'test_helper'

class WeeklytimetablesearchTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Weeklytimetablesearch.new.valid?
  end
end
