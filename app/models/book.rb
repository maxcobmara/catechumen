class Book < ActiveRecord::Base
  belongs_to :staff  , :foreign_key => 'receiver_id'
  belongs_to :addbook, :foreign_key => 'supplier_id'
  has_many  :accessions
  accepts_nested_attributes_for :accessions, :allow_destroy => true 
  
  
  #-----------Attach Photo---------------
  has_attached_file :photo
 #validates_attachment_size :photo, :less_than => 8.kilobytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']    
  
  #------------Validation-----------------------------------------
  validates_presence_of   :title , :isbn, :author #:issn, :classlcc, :classddc,  :publisher, :loantype, :mediatype
  validates_presence_of  #:subject, :publish_date, :publish_location, :description
  
  
  #def tag_suggest
 #   if Book.last.id == nil
  #    1
  #  else
  #    (Book.last.id + 1).to_s
   # end
  #end
  
  def bil
     v=1
  end
    
  def self.search(search)
    if search
        @book = Book.find(:all, :conditions => ["isbn LIKE ? or title ILIKE ? or author ILIKE ? or subject ILIKE ?" , "%#{search}%","%#{search}%","%#{search}%", "%#{search}%"])
    else
       @book = Book.find(:all)
    end
  end
  
  def book_quantity
        counter = Accession.count(:all, :conditions => ["book_id = ?", id])
  end
  

  
  
  LOAN = [
        #  Displayed       stored in db
        [ "Pinjaman Biasa",1 ],
        [ "Pinjaman Tetap", 2 ],
        [ "Pinjaman Sementara", 3 ],
        [ "Pinjaman Khas", 4 ]
  ]
  
  LANGUAGE = [
        #  Displayed       stored in db
        [ "English", "EN" ],
        [ "Bahasa Malaysia", "ms_MY" ]
  ]
  
  MEDIA = [
         #  Displayed       stored in db
         [ "Bahan Bercetak Buku",1 ],
         [ "Bahan Bercetak Bukan Buku",2 ],
         [ "Bahan Bukan Bercetak", 3 ]
  ]
  
  STATUS = [
          #  Displayed       stored in db
          [ "Ada",1 ],
          [ "Pinjam",2 ],
          [ "Dibaiki", 3 ],
          [ "Di Lupus", 4 ]
] 
  CATSOURCE = [
          #  Displayed       stored in db
          [ "Perpustakaan Negara",1 ],
          [ "Amazon.com",2 ],
          [ "Others",3 ]
]
  
end
