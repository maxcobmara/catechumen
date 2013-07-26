require 'test_helper'

class CurriculumsearchTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Curriculumsearch.new.valid?
  end
end
