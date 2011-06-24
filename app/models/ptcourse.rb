class Ptcourse < ActiveRecord::Base
  belongs_to :trainer, :class_name => 'Addbook', :foreign_key => 'provider'
  has_many :ptschedules
  
  validates_presence_of :name, :provider
  
  
  
  def rendered_course_type
    (Ptcourse::COURSE_TYPE.find_all{|disp, value| value == course_type }).map {|disp, value| disp}
  end
  
  def rendered_course_duration
    (Ptcourse::DUR_TYPE.find_all{|disp, value| value == duration_type }).map {|disp, value| disp}
  end
  
  COURSE_TYPE = [
       #  Displayed       stored in db
       [ "In-House",              5 ],
       [ "External Short Course",10 ],
       [ "Seminar",              15 ],
       [ "Certificate",          20 ],
       [ "Diploma/Others",       25 ],
  ]
  
  DUR_TYPE = [
       #  Displayed       stored in db
       [ "Days",  1 ],
       [ "Months",2 ],
       [ "Years", 3 ],
  ]
end
