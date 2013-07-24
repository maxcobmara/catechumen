require 'test_helper'

class StudentsearchTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Studentsearch.new.valid?
  end
end
