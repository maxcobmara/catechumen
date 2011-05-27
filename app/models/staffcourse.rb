class Staffcourse < ActiveRecord::Base
  
  validates_presence_of :name, :type
  has_many :trainingrequests
  
  
  def rendered_course_type
    (Staffcourse::COURSE_TYPE.find_all{|disp, value| value == coursetype }).map {|disp, value| disp}
  end
  
  def rendered_course_duration
    (Staffcourse::DUR_TYPE.find_all{|disp, value| value == duration_type }).map {|disp, value| disp}
  end
  
  COURSE_TYPE = [
       #  Displayed       stored in db
       [ "In-House",1 ],
       [ "External Short Course",2 ],
       [ "Certificate", 3 ],
       [ "Diploma/Others", 4],
  ]
  
  DUR_TYPE = [
       #  Displayed       stored in db
       [ "Days",1 ],
       [ "Months",2 ],
       [ "Years", 3 ],
  ]
  
  
end
