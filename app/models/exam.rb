class Exam < ActiveRecord::Base
  belongs_to  :creator,       :class_name => 'Staff',   :foreign_key => 'created_by'
  #belongs_to  :programme,   :foreign_key => 'course_id'
  belongs_to :subject,  :class_name => 'Programme', :foreign_key => 'subject_id'
  has_and_belongs_to_many :examquestions
  has_many :exammarks   #11Apr2013
  
  before_save :set_sequence
  
  attr_accessor :own_car, :dept_car,:programme_id #18Apr2013-programme_id used in views/exams/new.html.erb #9Apr2013-use course_id (temp) to capture semester (year as well)
  attr_accessor :programme_filter, :subject_filter, :topic_filter, :seq
  
  validates_presence_of :programme_id,:subject_id
  
  def set_sequence
    if seq!= nil
        sequence=""
        seq.each_with_index do |s,index|
          sequence = sequence + s +","
        end
        self.sequ = sequence
    end
  end
  
  def creator_details 
    if creator.blank? 
       "None Assigned"
     else 
       creator.name #mykad_with_staff_name
     end
  end
  
  #10Apr2013
  def total_marks   #to confirm full marks calculation - based on questiontype & exam paper format..
      sum = Exam.find(:all, :joins => :examquestions, :conditions=>['exam_id=? and questiontype=?', id, 'MCQ']).count
      seq_count = Exam.find(:all, :joins => :examquestions, :conditions=>['exam_id=? and questiontype=?', id, 'SEQ']).count
      sum=sum+(seq_count)*10 if seq_count > 0
      return sum
  end
  
  def exam_name_date
    "#{name}"+" - "+"#{exam_on.strftime("%d-%B-%Y")}"
  end
  #10Apr2013
  
  def exam_name_subject_date
     "#{name}"+" - "+"#{subject.subject_list}"+" - "+"#{exam_on.strftime("%d %B %Y")}"# +"#{subject.parent.course_type}"
  end
  
  def exam_code_date
    "#{subject.code}"+" | "+"#{exam_on.strftime("%d %b %y")}"
  end
  
  def set_year
    return  "1" if (subject.parent.code == "1") || (subject.parent.code == "2")
    return  "2" if (subject.parent.code == "3") || (subject.parent.code == "4")
    return "3" if (subject.parent.code == "5") || (subject.parent.code == "6")
    #syear
  end
  
  def full_exam_name
    "#{name}"+" - Tahun "+set_year.to_s+", "+"#{subject.parent.course_type}"+" "+"#{subject.parent.code}"+" - "+"#{subject.subject_list}"+" - "+"#{exam_on.strftime("%d %B %Y")}"
  end
  
end
