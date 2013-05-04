class Message < ActiveRecord::Base
  #29Apr2012--
  has_and_belongs_to_many :staffs#, :foreign_key => 'message_id'
  #belongs_to  :staff, :foreign_key => 'to_id'
  #29Apr2012--
  belongs_to  :from, :class_name => 'User', :foreign_key => 'from_id'
  
  before_save :varmyass
    
  def varmyass
    self.from_id = User.current_user.id
  end
 
  def from_staff
     suid = from_id.to_a
     exists = User.find(:all, :select => "id").map(&:id)
     checker = suid & exists

     if from_id == nil
       ""
     elsif checker == []
       "-"
     else
       from.user_nama
     end
   end
 
 def to_name
	#27 - 29Apr2012 ---------------------
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
	#27 - 29Apr2012 ---------------------
	#staff.name if staff
  end
  
  def to_name=(name)
	#self.staff = Staff.find_by_name(name) unless name.blank?
	self.staffs = Staff.find_by_name(name) unless name.blank?	#27-29 Apr 2012 --
  end
  
  #Remove whitespace, retrieve staff_id of recipient & assign into array
  def self.set_recipient(recipients)
	recipient_no_wspace = recipients.gsub(/(\s+, +|,\s+|\s+,)/,',')			#remove whitespace - result :"Saa, Sul ,Ali , Abu" become "Saa,Sul,Ali,Abu"
	@to_name_A = recipient_no_wspace.split(",")								          #assign recipient string into array - result : ["Saadah","Sulijah"]
	@to_id_A = []
   	@to_name_A.each do |to_name|
   		aa = Staff.find_by_name(to_name).id									
   		@to_id_A << aa.to_i							#result(sample)- ["1","7"]
   	end
	return @to_id_A
  end
  
end
