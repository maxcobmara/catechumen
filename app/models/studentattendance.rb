class Studentattendance < ActiveRecord::Base
	 belongs_to :klass, :class_name => "Klass", :foreign_key => 'timetable_id'
	 belongs_to :timetable
   has_and_belongs_to_many :students
    
   def counter
      v=1
   end 
   
   def klass_for_student
     if klass.blank?
       "N/A"
     else
       klass.name
     end
   end
  
   
  def student_details
      suid = student_id.to_a
      exists = Student.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if student_id == nil
        ""
      elsif checker == []
        "-"
      else
        student.student_name_with_programme
      end
  end

end
