class Accession < ActiveRecord::Base
  has_many :librarytransactions, :foreign_key => 'book_id'#, :dependent => :delete_all
  belongs_to :book
  
  def acc_book
    "#{accession_no} - #{book.title}"
  end
  
end
