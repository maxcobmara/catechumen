class Accession < ActiveRecord::Base
  has_many :librarytransactions
  belongs_to :book
  
  def acc_book
    "#{accession_no} - #{book.title}"
  end

  def self.search3(search3)
     if search3
      @accessions3 = Accession.find(:all, :conditions => ["accession_no LIKE (?) AND id not in (?)", "%#{search3}%",Librarytransaction.all.map(&:accession_id)], :order => "accession_no ASC")
     else
      @accessions3 = Accession.find(:all,  :order => :accession_no)
     end
  end
  
end
