class Tenant < ActiveRecord::Base
  belongs_to :location, :class_name => 'Location',  :foreign_key => 'location_id'
  belongs_to :staff
  belongs_to :student
  
 
  
  def student_name #16/11/2011 - Shaliza added code for student if no longer exist.
      suid = student_id.to_a
      exists = Student.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if student_id == nil
        ""
      elsif checker == []
        "Student No Longer Exists"
      else
        student.student_name_with_programme
      end
    end

    def staff_name #16/11/2011 - Shaliza added code for staff if no longer exist.
       suid = staff_id.to_a
       exists = Staff.find(:all, :select => "id").map(&:id)
       checker = suid & exists

       if staff_id == nil
         ""
       elsif checker == []
         "Staff No Longer Exists"
       else
         staff.staff_name_with_position
       end
     end

     def location_name #16/11/2011 - Shaliza added code for location if no longer exist.
        suid = location_id.to_a
        exists = Location.find(:all, :select => "id").map(&:id)
        checker = suid & exists

        if location_id == nil
          ""
        elsif checker == []
          "Location No Longer Exists"
        else
          location.location_list
        end
      end

      def location_typename #16/11/2011 - Shaliza added code for typename if no longer exist.
          suid = location_id.to_a
          exists = Location.find(:all, :select => "id").map(&:id)
          checker = suid & exists

          if location_id == nil
            ""
          elsif checker == []
            "Location No Longer Exists"
          else
            location.typename
          end
        end

      def course_details
           suid = student_id.to_a
           exists = Student.find(:all, :select => "id").map(&:id)
           checker = suid & exists

           if student_id == nil
             ""
           elsif checker == []
             "Course No Longer Exists"
           else
             student.programme_for_student
           end
       end
  
end

