class Bulletin < ActiveRecord::Base
  
  validates_presence_of :headline, :content, :postedby_id, :publishdt

  belongs_to :staff,  :foreign_key => 'postedby_id' 
  # validates_format_of    :headline, :with => /^[a-zA-Z'` ]+$/, :message => "contains illegal characters"
  
  #-------------Upload Document---------------#
   
   has_attached_file :data,
                     :url => "/assets/bulletins/:id/:style/:basename.:extension",
                     :path => ":rails_root/public/assets/bulletins/:id/:style/:basename.:extension"
   #validates_attachment_content_type :data, :content_type => ['application/pdf','application/txt', 'application/msword','application/msexcel','image/png','image/jpeg','text/plain'],
                          #:storage => :file_system,
                          #:message => "Invalid File Format" 
   validates_attachment_size :data, :less_than => 5.megabytes
   
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
     
     
     
  def posted_details 
      suid = postedby_id.to_a
      exists = Staff.find(:all, :select => "id").map(&:id)
      checker = suid & exists     

      if postedby_id == nil
         "" 
      elsif checker == []
          "Staff No Longer Exists" 
      else
        staff.mykad_with_staff_name
      end
  end
end
