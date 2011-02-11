class Librarytransaction < ActiveRecord::Base
  belongs_to :book, :foreign_key => 'book_id'
  belongs_to :staff
  belongs_to :student
end
