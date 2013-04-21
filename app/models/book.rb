class Book < ActiveRecord::Base
  belongs_to :staff  , :foreign_key => 'receiver_id'
  belongs_to :addbook, :foreign_key => 'supplier_id'
  
  has_many  :accessions, :dependent => :destroy
  accepts_nested_attributes_for :accessions, :reject_if => lambda { |a| a[:accession_no].blank? }, :allow_destroy =>true
  
  before_save :extract_roman_into_size_pages
  
  #-----------Attach Photo---------------
  has_attached_file :photo,
                    :url => "/assets/books/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/books/:id/:style/:basename.:extension"
  validates_attachment_size :photo, :less_than => 500.kilobytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']    
  
  #------------Validation-----------------------------------------
  #validates_presence_of  :isbn, :classlcc, :classddc, :title, :author, :publisher, :loantype, :mediatype  #:issn,
  #validates_presence_of  :subject, :publish_date, :publish_location, :roman, :size, :pages
  
  validates_uniqueness_of :isbn, :allow_nil => true, :allow_blank => true
  
  #attr_accessor :list_type
  
  def extract_roman_into_size_pages
    self.backuproman = roman
    if roman != nil
      ar = roman.split(',')
      ar2 = roman.split(';')
      ar3 = roman.split(':')
    end
    
    if ar.size==3
      self.roman = ar[0]
    elsif ar.size==2
      self.roman = ''
    end
    if size=='' && ar.size==3
      self.size = ar[1]
    elsif size='' && ar.size==2
      self.size = ar[0]
    end
    if pages=='' && ar.size==3
      self.pages = ar[2]
    elsif pages =='' && ar.size==2
      self.pages = ar[1]
    end
    
    #repetive for ar2 
    if ar2.size==3
      self.roman = ar2[0]
    elsif ar2.size==2
      self.roman = ''
    end
    if size=='' && ar2.size==3
      self.size = ar2[1]
    elsif size='' && ar2.size==2
      self.size = ar2[0]
    end
    if pages=='' && ar2.size==3
      self.pages = ar2[2]
    elsif pages =='' && ar2.size==2
      self.pages = ar2[1]
    end

    #repetive for ar3 
    if ar3.size==3
      self.roman = ar3[0]
    elsif ar3.size==2
      self.roman = ''
    end
    if size=='' && ar3.size==3
      self.size = ar3[1]
    elsif size='' && ar3.size==2
      self.size = ar3[0]
    end
    if pages=='' && ar3.size==3
      self.pages = ar3[2]
    elsif pages =='' && ar3.size==2
      self.pages = ar3[1]
    end
    #-----
    if tagno == nil
      if Book.last.tagno == nil
        self.tagno=1
      else
        #(Book.last.id + 1).to_s
        self.tagno = (Book.tagno.id + 1).to_s
      end
      
    end 
  end
  
  def tag_suggest
    #if Book.last.id == nil
    if Book.last.tagno == nil
      1
    else
      #(Book.last.id + 1).to_s
      (Book.tagno.id + 1).to_s
    end
  end

  #lists
  #def isbn #document_refno
    #book.isbn if book #document.refno if document
  #end
  
  #def isbn=(refno)
    #self.isbn = Book.find_by_isbn(refno) unless refno.blank?
    #self.document = Document.find_by_refno(refno) unless refno.blank?
  #end

    
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
        [ "Bahasa Malaysia", "ms_MY" ],
        [ "Lain-Lain", "lain"]
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
