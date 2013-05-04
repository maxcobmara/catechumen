class Trainingreport < ActiveRecord::Base
  
   belongs_to :timetable
   belongs_to :staff
   belongs_to :tpa, :class_name => 'Staff', :foreign_key => 'tpa_id'

    belongs_to :topic

   CTYPE = [
         # Displayed stored in db
         [ "Kuliah",1 ],
         [ "Tutorial",2 ],
         [ "Amali",3 ]
   ]
   
   
   def tpa_staff_details
     suid = tpa_id.to_a
     exists = Staff.find(:all, :select => "id").map(&:id)
     checker = suid & exists

     if tpa_id == nil
       ""
     elsif checker == []
       "-"
     else
       tpa.staff_name_with_title
     end
   end
   
    def timetable_staff_details
      suid = timetable_id.to_a
      exists = Timetable.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if timetable_id == nil
        ""
      elsif checker == []
        "-"
      else
        timetable.staff_details
      end
    end
   
   
end
