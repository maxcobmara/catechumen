class Bulletin < ActiveRecord::Base
  
  def titleize_headline
    self.headline = headline.titleize
  end
  

    
  
   #belongs_to :bulletin, :foreign_key => 'staff_id'
   #belongs_to :bulletin, :class_name => 'Staff', :foreign_key => 'staff_id'   ! why do you need TWO?! and they are both WRONG!!!!
   
   #1. belongs_to :staff  ::::  you do not need to declare anything else if there is only one field that links tables
   #2. class_name =>  only required if you have multiple fileds referencing the same table 
   #3. foreign_key  ::: only declared if the :modelname is not the same as modelname_id
   #4. Read the code   class Bulletin (i.e this class you declared on top) belongs_to :bulletin .... do you know what you are doing?
   
   #read mine   ::: Bulletin belongs_to :staff where the foreign key is postedby_id
   
   belongs_to :staff,  :foreign_key => 'postedby_id'  #ok now see the index for this
   
   validates_presence_of :headline, :content, :postedby_id, :publishdt
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
     validates_attachment_content_type :data, :content_type => ['application/pdf','application/txt', 'application/msword','application/msexcel','image/png','image/jpeg','text/plain'],
                            :storage => :file_system,
                            :message => "Invalid File Format" 
     validates_attachment_size :data, :less_than => 5.megabytes
end
