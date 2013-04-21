class Trainingreport < ActiveRecord::Base
  
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  
  belongs_to :timetable
  belongs_to :creator,  :class_name => 'Staff',  :foreign_key => 'staff_id'
  belongs_to :tpa,      :class_name => 'Staff',   :foreign_key => 'tpa_id'
  

  validates_presence_of :classtype#, :location_state
  validates_presence_of :location_comment, :if => :locstate_con?
 
  def locstate_con?
    location_state != true
  end
  
  def edit_icon
    if staff_id == User.current_user.staff_id
      "edit.png"
    elsif tpa_id == User.current_user.staff_id
      "approval.png"
    else
      ""
    end
  end
  
  
  
  
  
  
  
  CTYPE = [
        #  Displayed       stored in db
        [ "Kuliah",1 ],
        [ "Tutorial",2 ],
        [ "Amali",3 ]
  ]
end
