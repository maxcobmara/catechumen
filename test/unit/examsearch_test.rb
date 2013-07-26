require 'test_helper'

class ExamsearchTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Examsearch.new.valid?
  end
end
