class Bulletin < ActiveRecord::Base
  
  validates_presence_of :headline, :content, :postedby_id, :publishdt

  belongs_to :staff,  :foreign_key => 'postedby_id' 
  # validates_format_of    :headline, :with => /^[a-zA-Z'` ]+$/, :message => "contains illegal characters"
   
    def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])     
    end
    
     def self.search(search)
        if search
         @bulletin = Bulletin.find(:all, :conditions => ["headline ILIKE ? or content ILIKE ?", "%#{search}%","%#{search}%"], :order => :publishdt)
        
       else
        @bulletin = Bulletin.find(:all,  :order => :publishdt)
       end
     end
     
   #def self.publishdt
   #  @bulletin = Bulletin.find_by_date([ Date.today, Date.today + 1])
  # end
     
     #-------------Upload Document---------------#
     
     has_attached_file :data
     #validates_attachment_content_type :data, :content_type => ['application/pdf','application/txt', 'application/msword','application/msexcel','image/png','image/jpeg','text/plain'],
                            #:storage => :file_system,
                            #:message => "Invalid File Format" 
     validates_attachment_size :data, :less_than => 5.megabytes
end
