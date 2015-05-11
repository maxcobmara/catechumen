class Ptschedule < ActiveRecord::Base
  belongs_to :ptcourse
  validates_presence_of :ptcourse_id, :message => "Please Select Course"
  validates_presence_of :start, :location, :min_participants, :max_participants
  has_many :ptdos, :dependent => :destroy
  
  def enddate
    duration=Ptdo.staff_course_days(Ptcourse.find(ptcourse_id))
    bal_hours = duration % 6
    days_count = duration / 6
    if bal_hours >= 3                 #6 hours=1 day
      duration=days_count+1
    end
    start+duration.to_i.day
  end
  
#   def course_duration
#     duration=Ptdo.staff_course_days(Ptcourse.find(ptcourse_id))
#     duration_in_string=Ptdo.staff_total_days(ptdos.map(&:id))
#   end
  
end
