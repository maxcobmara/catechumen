class Document < ActiveRecord::Base
# has_many :cofiles, :foreign_key => 'document_id'
#belongs_to :documents, :foreign_key => 'staff_id'
# has_one :title

has_and_belongs_to_many :staffs

validates_presence_of :refno, :category, :title, :letterdt, :letterxdt, :from, :stafffiled_id

belongs_to :stafffilled,    :class_name => 'Staff', :foreign_key => 'stafffiled_id'
belongs_to :cc1staff, :class_name => 'Staff', :foreign_key => 'cc1staff_id' 
belongs_to :cc2staff, :class_name => 'Staff', :foreign_key => 'cc2staff_id'
belongs_to :actiontaken, :class_name => 'Staff', :foreign_key => 'action_by'
belongs_to :cofile, :foreign_key => 'file_id'

before_save :set_actionstaff2_to_blank_if_close_is_selected

has_many :circulates, :dependent => :destroy
accepts_nested_attributes_for :circulates, :reject_if => lambda { |a| a[:cc_staff].blank? }

def set_actionstaff2_to_blank_if_close_is_selected
    if cc1closed == true
      self.cc2staff_id = nil
    end
end

def cc2_staff
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

def cc2_staff=(name)
  	self.staffs = Staff.find_by_name(name) unless name.blank?		#27-29 Apr 2012 --
end

    
#def self.set_recipient(recipients)
#  	recipient_no_wspace = recipients.gsub(/(\s+, +|,\s+|\s+,)/,',')			#remove whitespace - result :"Saa, Sul ,Ali , Abu" become "Saa,Sul,Ali,Abu"
#  	@cc2_staff_A = recipient_no_wspace.split(",")								          #assign recipient string into array - result : ["Saadah","Sulijah"]
#  	@to_id_A = []
#     	@cc2_staff_A.each do |cc2_staff|
#     		aa = Staff.find_by_name(cc2_staff).id									
#     		@to_id_A << aa.to_i													#result(sample)- ["1","7"]
#     	end
#  	return @to_id_A
#end

def filedocer
    suid = file_id
    Cofile.find(:all, :select => "name", :conditions => {:id => suid}).map(&:name)
end

  def sv
      Document.last.id + 1
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
    
  
#---------------------AttachFile------------------------------------------------------------------------
 has_attached_file :data
 validates_attachment_content_type :data, :content_type => ['application/pdf', 'application/msword','application/msexcel','image/png','text/plain'],
                        :storage => :file_system,
                        :message => "Invalid File Format" 
 validates_attachment_size :data, :less_than => 5.megabytes

 #has_attached_file :doc
# validates_attachment_content_type :doc, :content_type => ['application/pdf', 'application/msword','application/msexcel','image/png','text/plain'],
#                         :storage => :file_system,
#                         :message => "Invalid File Format" 
# validates_attachment_size :doc, :less_than => 5.megabytes
#----------------Coded List----------------------------------- 
CATEGORY = [
        #  Displayed       stored in db
        [ "Surat","1" ],
        [ "Memo","2" ],
        [ "Pekeliling", "3" ],
        [ "Perintah Am", "4" ],
        [ "Perintah Tetap KP", "5" ],
        [ "Buletin", "6" ],
        [ "Lain-Lain", "7" ]
        
 ]
 
 ACTION = [
         #  Displayed       stored in db
         [ "Segera","1" ],
         [ "Biasa","2" ],
         [ "Makluman", "3" ]
  ]
  
  CLASSIFICATION = [
           #  Displayed       stored in db
           [ "Peringkat","1" ],
           [ "Tidak Peringkat","2" ]
    ]
   def stafffiled_details 
         suid = stafffiled_id.to_a
         exists = Staff.find(:all, :select => "id").map(&:id)
         checker = suid & exists     

         if stafffiled_id == nil
            "" 
          elsif checker == []
            "Staff No Longer Exists" 
         else
           stafffilled.staff_name_with_title
         end
    end
    
    
    #circulation I
     def circulation1_details 
         suid = cc1staff_id.to_a
         exists = Staff.find(:all, :select => "id").map(&:id)
         checker = suid & exists     

         if cc1staff_id == nil
            "" 
          elsif checker == []
            "Staff No Longer Exists" 
         else
           cc1staff.staff_name_with_title
         end
    end
    
     #circulation II
       def circulation2_details 
           suid = cc2staff_id.to_a
           exists = Staff.find(:all, :select => "id").map(&:id)
           checker = suid & exists     

           if cc2staff_id == nil
              "" 
            elsif checker == []
              "Staff No Longer Exists" 
           else
             cc2staff.staff_name_with_title
           end
      end


  
end
