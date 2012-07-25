class Book < ActiveRecord::Base
  belongs_to :staff  , :foreign_key => 'receiver_id'
  belongs_to :addbook, :foreign_key => 'supplier_id'
  
  has_many  :accessions, :dependent => :destroy
  accepts_nested_attributes_for :accessions, :reject_if => lambda { |a| a[:accession_no].blank? }, :allow_destroy =>true
  
  
  #-----------Attach Photo---------------
  has_attached_file :photo,
                    :url => "/assets/books/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/books/:id/:style/:basename.:extension"
  validates_attachment_size :photo, :less_than => 500.kilobytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']    
  
  #------------Validation-----------------------------------------
  validates_presence_of  :isbn, :issn, :classlcc, :classddc, :title, :author, :publisher, :loantype, :mediatype
  validates_presence_of  :subject, :publish_date, :publish_location, :roman, :size, :pages
  
  
  def tag_suggest
    if Book.last.id == nil
      1
    else
      (Book.last.id + 1).to_s
    end
  end



    
def self.search(search)
    if search
        @book = Book.find(:all, :conditions => ["isbn LIKE ? or title ILIKE ? or author ILIKE ? or location ILIKE ?" , "%#{search}%","%#{search}%","%#{search}%", "%#{search}%"], :order => :title)
    else
       @book = Book.find(:all, :order => :title)
    end
end
  
 def book_quantity
      counter = Accession.count(:all, :conditions => ["book_id = ?", id])
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
