require 'test_helper'

class DocumentsearchTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Documentsearch.new.valid?
  end
end
