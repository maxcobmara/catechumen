require 'test_helper'

class StudentattendancesearchTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Studentattendancesearch.new.valid?
  end
end
