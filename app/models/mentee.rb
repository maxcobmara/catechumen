class Mentee < ActiveRecord::Base
 belongs_to :mentor 
 belongs_to :student
 
 validates_presence_of :student_id, :message => "Can't Be Blank"
 
 has_many :mentorname, :class_name => 'Sdicipline', :foreign_key => 'mentor_id' 
 
 def mentee_for_mentor
   if student.blank?
     "-"
   else
     student.name
   end
 end
 
  def mentorstaff
    if mentor.blank?
       "-"
     else
       mentor.staff.staff_name_with_title
    end
   end
   
   def mentor_mentee
      "#{mentorstaff} - #{mentee_for_mentor}"
   end
   
     def bil
        v=1
     end
end
