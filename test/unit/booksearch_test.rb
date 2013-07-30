require 'test_helper'

class BooksearchTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Booksearch.new.valid?
  end
end
