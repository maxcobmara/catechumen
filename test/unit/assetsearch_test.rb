require 'test_helper'

class AssetsearchTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Assetsearch.new.valid?
  end
end
