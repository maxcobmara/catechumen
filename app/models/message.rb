class Message < ActiveRecord::Base
  has_and_belongs_to_many   :staffs
  belongs_to                :from, :class_name => 'User', :foreign_key => 'from_id'
  
  before_save :varmyass
  def varmyass
    self.from_id	= User.current_user.id
  end
  
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

end
