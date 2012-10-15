class Exam < ActiveRecord::Base
  belongs_to  :creator,       :class_name => 'Staff',   :foreign_key => 'created_by'
  belongs_to  :programme,   :foreign_key => 'course_id'
  has_and_belongs_to_many :examquestions
  
  
  def creator_details 
    if creator.blank? 
       "None Assigned"
     else 
       creator.name #mykad_with_staff_name
     end
  end
  
end
