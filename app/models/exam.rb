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
  validate :sequence_must_be_selected, :sequence_must_be_unique#,:sequence_must_increment_by_one
  
  def set_sequence
    if seq!= nil
        sequence=""
        seq.each_with_index do |s,index|
            sequence = sequence + s +","
        end
        if examquestion_ids.count > seq.count
            diff_count = examquestion_ids.count - seq.count
            0.upto(diff_count-1) do |c|
                sequence = sequence + "Select"+","
            end
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
      
      meq_q = Exam.find(:all, :joins => :examquestions, :conditions=>['exam_id=? and questiontype=?', id, 'MEQ'],:select=>'marks').map{|x|x.marks}  
      sum_meq=0
      meq_q.each do |t|
        sum_meq+=t.to_i
      end
      acq_q = Exam.find(:all, :joins => :examquestions, :conditions=>['exam_id=? and questiontype=?', id, 'ACQ'],:select=>'marks').map{|x|x.marks}  
      sum_acq=0
      acq_q.each do |t|
        sum_acq+=t.to_i
      end 
      osci_q = Exam.find(:all, :joins => :examquestions, :conditions=>['exam_id=? and questiontype=?', id, 'OSCI'],:select=>'marks').map{|x|x.marks}  
      sum_osci=0
      osci_q.each do |t|
        sum_osci+=t.to_i
      end
      oscii_q = Exam.find(:all, :joins => :examquestions, :conditions=>['exam_id=? and questiontype=?', id, 'OSCII'],:select=>'marks').map{|x|x.marks}  
      sum_oscii=0 
      oscii_q.each do |t|
        sum_oscii+=t.to_i
      end
      sum=sum+sum_meq+sum_acq+sum_osci+sum_oscii
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
  end
  
  def set_semester
    return  "1" if (subject.parent.code == "1") || (subject.parent.code == "3")||(subject.parent.code == "5") 
    return  "2" if  (subject.parent.code == "2") || (subject.parent.code == "4") || (subject.parent.code == "6")
  end
  
  def full_exam_name
    "#{name}"+" - Tahun "+set_year.to_s+", "+"#{subject.parent.course_type}"+" "+set_semester.to_s+" - "+"#{subject.subject_list}"+" - "+"#{exam_on.strftime("%d %B %Y")}"
     #  "#{name}"+" - Tahun "+set_year.to_s+", "+"#{subject.parent.course_type}"+" "+"#{subject.parent.code}"+" - "+"#{subject.subject_list}"+" - "+"#{exam_on.strftime("%d %B %Y")}"
  end
  

private

  def sequence_must_increment_by_one
    if seq!= nil
        y=0
        result = true
        seq.sort_by{|k|k.to_i}.each do |x|  #tosort_seqid.sort_by{|k,v|k.to_i}.each do |x,y|  #asalnye:seq.sort.each do |x|
          z=x.to_i
          if y && ((z-y) != 1)
               result = false
          end 
          y=z 
        end
        if result == false && seq.include?("Select") == false                     #sequence increment by 1 can only be checked for selected sequence!
            errors.add_to_base("Sequence for all questions must increase by 1.")  
        end
    end
  end
  
  def sequence_must_be_selected
    if seq!= nil
        if seq.include?("Select") == true   #means sequence not yet selected
            errors.add_to_base("Sequence for each question must be selected.")
        end
    end
  end
  
  def sequence_must_be_unique
    if seq!= nil
        if seq.uniq.length != seq.length && seq.include?("Select") == false       #sequence UNIQUENESS can only be checked for selected sequence!
            errors.add_to_base("Sequence for each question must be unique.")
        end
    end
  end
  
end
