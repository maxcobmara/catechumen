class Document < ActiveRecord::Base
# has_many :cofiles, :foreign_key => 'document_id'
#belongs_to :documents, :foreign_key => 'staff_id'
# has_one :title


belongs_to :staff, :foreign_key => 'stafffiled_id'
belongs_to :cofile, :foreign_key => 'file_id'





 def self.find_main
    Document.find(:all, :condition => ['document_id IS NULL'])
  end
  
  def self.find_main
      Cofile.find(:all, :condition => ['cofile_id IS NULL'])
  end


#-------------------------Search---------------------------------------------------  
  def self.search(search)
       if search
         find(:all, :conditions => ['refno ILIKE ? or title ILIKE ?', "%#{search}%", "%#{search}%"])
      else
       find(:all)
      end
  end
    
  
#---------------------AttachFile------------------------------------------------------------------------
 has_attached_file :data
 validates_attachment_content_type :data, :content_type => ['application/pdf', 'application/msword','application/msexcel','image/png','text/plain'],
                        :storage => :file_system,
                        :message => "Invalid File Format" 
 validates_attachment_size :data, :less_than => 5.megabytes


#----------------Coded List----------------------------------- 
CATEGORY = [
        #  Displayed       stored in db
        [ "Surat","1" ],
        [ "Memo","2" ],
        [ "Pekeliling", "3" ],
        [ "Lain-Lain", "4" ]
 ]
   
validates_presence_of :serialno, :refno, :category, :title, :letterdt, :letterxdt, :from, :stafffiled_id, :file_id
end
