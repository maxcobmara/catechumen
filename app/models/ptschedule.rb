class Ptschedule < ActiveRecord::Base

  before_save :varmyass
  belongs_to :ptcourse
  validates_presence_of :branch
  has_many :ptdos
  
  def bil
      v=1
   end
   
  DUR_TYPE = [
       #  Displayed       stored in db
       [ "Hours",  1 ],
       [ "Days",2 ]
  ]
  
  
  
  def varmyass
  self.total_speaker = speaker
	self.total_meal = meal
	self.big_total = total
#	self.total_speaker_hour = rate_speaker_byhour
  end
   
   def speaker
		allowance_speaker * duration
   end
   
    def rate_speaker_byhour
		allowance_speaker * rate_speaker
   end
   
   
   def meal
		(meals * min_participants) * duration
   end
   
    def total
		if rate_speaker == nil
			speaker + meal
		else
			rate_speaker_byhour + meal
		end
   end
    
    
def course_name
    suid = ptcourse_id.to_a
    suexists = Ptcourse.find(:all, :select => "id").map(&:id)
    filechecker = suid & suexists

    if ptcourse_id == nil
          ""
    elsif filechecker == []
          "Course No Longer Exists"
    else
          ptcourse.name 
    end 
end

def course_desc
    suid = ptcourse_id.to_a
    suexists = Ptcourse.find(:all, :select => "id").map(&:id)
    filechecker = suid & suexists

    if ptcourse_id == nil
          ""
    elsif filechecker == []
          "-"
    else
          ptcourse.description 
    end 
end

def course_duration
    suid = ptcourse_id.to_a
    suexists = Ptcourse.find(:all, :select => "id").map(&:id)
    filechecker = suid & suexists

    if ptcourse_id == nil
          ""
    elsif filechecker == []
          "-"
    else
          ptcourse.duration 
    end 
end

def course_duration_type
    suid = ptcourse_id.to_a
    suexists = Ptcourse.find(:all, :select => "id").map(&:id)
    filechecker = suid & suexists

    if ptcourse_id == nil
          ""
    elsif filechecker == []
          "-"
    else
          ptcourse.rendered_course_duration 
    end 
end

def course_type
    suid = ptcourse_id.to_a
    suexists = Ptcourse.find(:all, :select => "id").map(&:id)
    filechecker = suid & suexists

    if ptcourse_id == nil
          ""
    elsif filechecker == []
          "-"
    else
          ptcourse.rendered_course_type 
    end 
end

def trainer_course
    suid = ptcourse_id.to_a
    suexists = Ptcourse.find(:all, :select => "id").map(&:id)
    filechecker = suid & suexists

    if ptcourse_id == nil
          ""
    elsif filechecker == []
          "-"
    else
          ptcourse.trainer_name
    end 
end
end
