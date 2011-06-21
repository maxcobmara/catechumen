class Book < ActiveRecord::Base
  has_many :librarytransactions
  #belongs_to :addbook, :foreign_key => 'addbook_id'
  belongs_to :staff  , :foreign_key => 'receiver_id'
  belongs_to :addbook, :foreign_key => 'supplier_id'
  #belongs_to :cst, :class_name => 'Staff', :foreign_key => 'catsource'
  
  
  #-----------Attach Photo---------------
  has_attached_file :photo
  validates_attachment_size :photo, :less_than => 50.kilobytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']    
  
  #------------Validation-----------------------------------------
  validates_presence_of  :controlno, :isbn, :issn, :classlcc, :classddc, :title, :author, :publisher, :loantype, :mediatype
  
  
  

    
  def self.search(search)
    if search
        @book = Book.find(:all, :conditions => ["isbn LIKE ? or title ILIKE ? or author ILIKE ?", "%#{search}%","%#{search}%","%#{search}%"])
    else
       @book = Book.find(:all)
    end
  end
    

  
  
  LOAN = [
        #  Displayed       stored in db
        [ "Open Shelf",1 ],
        [ "Red Spot", 3 ]
  ]
  
  LANGUAGE = [
        #  Displayed       stored in db
        [ "English", "EN" ],
        [ "Bahasa Malaysia", "ms_MY" ]
  ]
  
  MEDIA = [
         #  Displayed       stored in db
         [ "Buku",1 ],
         [ "Majalah",2 ],
         [ "DVD", 3 ],
         [ "CD", 4]
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
          [ "Perustakaan Negara",1 ],
          [ "Amazon.com",2 ],
          [ "Others",3 ]
]
  
end
