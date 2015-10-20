class Accession < ActiveRecord::Base
  has_many :librarytransactions
  belongs_to :book
  before_destroy :valid_for_removal
  
  def acc_book
    "#{accession_no} - #{book.title}"
  end

  def self.search3(search3)
     if search3
      books_on_loan = Librarytransaction.find(:all, :select => 'accession_id', :conditions => ["returned = ? OR returned IS ?", false, nil ]).map(&:accession_id)
      @accessions3 = Accession.find(:all, :conditions => ["accession_no LIKE (?) AND id not in (?)", "%#{search3}%", books_on_loan], :order => "accession_no ASC")
     else
      @accessions3 = Accession.find(:all,  :order => :accession_no)
     end
  end
  
  #restrict deletion if exist in transaction
  def valid_for_removal 
    if Librarytransaction.all.map(&:accession_id).include?(id)
      return false
    else
      return true
    end
  end
  
end
