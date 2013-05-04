class Accession < ActiveRecord::Base
  has_many :librarytransactions, :foreign_key => 'book_id'#, :dependent => :delete_all
  belongs_to :book
  
  validates_uniqueness_of   :accession_no
  
   STATUS = [
             #  Displayed       stored in db
             [ "Ada",1 ],
             [ "Pinjam",2 ],
             [ "Dibaiki", 3 ],
             [ "Di Lupus", 4 ]
   ]
   
   def accession_book
     "#{accession_no} - #{title_book} - #{order_no} "
   end
   
   def title_book
      if book.blank?
        "-"
      else
        book.title
      end
    end
end
