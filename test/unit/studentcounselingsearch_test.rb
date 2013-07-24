require 'test_helper'

class StudentcounselingsearchTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Studentcounselingsearch.new.valid?
  end
end
