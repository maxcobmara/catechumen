require 'test_helper'

class LessonplansearchTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Lessonplansearch.new.valid?
  end
end
