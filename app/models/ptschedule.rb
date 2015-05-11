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
  
  def self.search(search)
    if search
      searched_ptcourses_ids=Ptcourse.find(:all, :conditions =>['name ILIKE (?)', "%#{search}%"]).map(&:id)
      ptschedules=Ptschedule.find(:all, :conditions => ['ptcourse_id IN(?) or location ILIKE (?)', searched_ptcourses_ids,"%#{search}%"])
    else
      ptschedules=Ptschedule.find(:all, :order => "start DESC")
    end 
    ptschedules
  end
  
end
