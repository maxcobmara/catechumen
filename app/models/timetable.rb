class Timetable < ActiveRecord::Base
  
  validates_presence_of :klass_id,:topic_id, :location_id, :staff_id, :start_at, :end_at
  belongs_to :klass     
  belongs_to :topic     
  belongs_to :staff     
  belongs_to :location   
                         
  def staff_details 
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
end
