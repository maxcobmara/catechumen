class Document < ActiveRecord::Base
# has_many :cofiles, :foreign_key => 'document_id'
#belongs_to :documents, :foreign_key => 'staff_id'
# has_one :title

validates_presence_of :serialno, :refno, :category, :title,  :from, :stafffiled_id#,:letterdt, :letterxdt

has_and_belongs_to_many   :staffs, :join_table => :documents_staffs   #5Apr2013

belongs_to :stafffilled,  :class_name => 'Staff', :foreign_key => 'stafffiled_id'
belongs_to :preparedby,   :class_name => 'Staff', :foreign_key => 'prepared_by'
belongs_to :cc1staff,     :class_name => 'Staff', :foreign_key => 'cc1staff_id' 
belongs_to :cofile,       :foreign_key => 'file_id'

has_many :asset_disposals
has_many :travel_requests

has_many :asset_disposals
has_many :travel_requests

before_save :set_actionstaff2_to_blank_if_close_is_selected

  #5Apr2013
  def self.set_serialno(id)
    if id
      Document.find(id).serialno
    else
      (Document.last.id)+1
    end
  end

  def set_actionstaff2_to_blank_if_close_is_selected
    if cc1closed == true
      self.cc2staff_id = nil
    end
  end


  def filedocer
    suid = file_id
    Cofile.find(:all, :select => "name", :conditions => {:id => suid}).map(&:name)
  end
  
  def owner_ids
    a = Array.new
    #a.push(stafffiled_id, cc1staff_id, cc2staff_id)
    a.push(stafffiled_id,prepared_by)#,cc1staff_id)
    a
  end




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
  def self.search2(search2)
       if search2
         find(:all, :conditions => ['letterdt=?',"#{search2}"])#@documents = Document.find(:all, :conditions=> ['letterdt=?',"#{@bob2}"])
         
      else
       find(:all)
      end
  end  
  
#---------------------AttachFile------------------------------------------------------------------------
 has_attached_file :data,
                    :url => "/assets/documents/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/documents/:id/:style/:basename.:extension"
 #validates_attachment_content_type :data, 
                        #:content_type => ['application/pdf', 'application/msword','application/msexcel','image/png','text/plain'],
                        #:storage => :file_system,
                        #:message => "Invalid File Format" 
 validates_attachment_size :data, :less_than => 5.megabytes
 
 #---------------------AttachFile-for circulation:action------------------------------------------------------
  has_attached_file :dataaction,
                     :url => "/assets/documents/:id/:style/:basename.:extension",
                     :path => ":rails_root/public/assets/documents/:id/:style/:basename.:extension"
  #validates_attachment_content_type :data, 
                         #:content_type => ['application/pdf', 'application/msword','application/msexcel','image/png','text/plain'],
                         #:storage => :file_system,
                         #:message => "Invalid File Format" 
  validates_attachment_size :dataaction, :less_than => 5.megabytes


#----------------Coded List----------------------------------- 
CATEGORY = [
        #  Displayed       stored in db
        [ "Surat",      "1" ],
        [ "Memo",       "2" ],
        [ "Pekeliling", "3" ],
        [ "Lain-Lain",  "4" ],
        [ "e-Mel",      "5" ]
 ]
 
 ACTION = [
         #  Displayed       stored in db
         [ "Segera","1" ],
         [ "Biasa","2" ],
         [ "Makluman", "3" ]
  ]
  
  def stafffiled_details 
    stafffilled.mykad_with_staff_name
  end
<<<<<<< HEAD
    
  def cc1staff_details 
    check_kin_blank {cc1staff.mykad_with_staff_name}
  end
    
  def file_details 
    cofile.file_no_and_name
=======
    
  def cc1staff_details 
    check_kin_blank {cc1staff.mykad_with_staff_name}
>>>>>>> 0da980ec7c2c95feb7bdc68cdebc6187e0fe20f4
  end
    
  def file_details 
    cofile.file_no_and_name
  end
    
  #5Apr2013  -------------------------------------

  def to_name
  	recipient_qty = staffs.count
  	staff_names = []
  	count = 0
  	for staff in staffs 
  		count+=1
  		if count != recipient_qty
  			staff_names << staff.name+"," 
  		else
  			staff_names << staff.name
  		end
  	end 
  	return staff_names
  end

  def to_name=(name)
	  self.staffs = Staff.find_by_name(name) unless name.blank?
  end
  
  #5Apr2013  -------------------------------------
  
  #8Apr2013 --------------------------------------
  def self.set_recipient(recipients)
    	recipient_no_wspace = recipients.gsub(/(\s+, +|,\s+|\s+,)/,',')     #remove whitespace
    	@to_name_A = recipient_no_wspace.split(",") 											  #will become - ["Saadah","Sulijah"]
    	@to_id_A = []
      @to_name_A.each do |to_name|
      	aa = Staff.find_by_name(to_name).id										            #result(sample)- ["1","7"]
        @to_id_A << aa.to_i
      end
      return @to_id_A
  end
  
  
end
