class Exam < ActiveRecord::Base
  belongs_to  :creator,       :class_name => 'Staff',   :foreign_key => 'created_by'
  #belongs_to  :programme,   :foreign_key => 'course_id'
  belongs_to :subject,  :class_name => 'Programme', :foreign_key => 'subject_id'
  has_and_belongs_to_many :examquestions
  has_many :exammarks   #11Apr2013
  has_many :examtemplates, :dependent => :destroy #10June2013
  accepts_nested_attributes_for :examtemplates, :reject_if => lambda { |a| a[:quantity].blank? }
  
  before_save :set_sequence
  
  attr_accessor :own_car, :dept_car,:programme_id #18Apr2013-programme_id used in views/exams/new.html.erb #9Apr2013-use course_id (temp) to capture semester (year as well)
  attr_accessor :programme_filter, :subject_filter, :topic_filter, :seq
  
  validates_presence_of :programme_id,:subject_id, :name
  validates_uniqueness_of :name, :scope => "subject_id", :message => " - Examination of selected exam type (name) for selected subject already exist."
  validate :sequence_must_be_selected, :sequence_must_be_unique #,:sequence_must_increment_by_one
  
  #remark : validation for:validates_uniqueness_of :name, :scope => "subject_id", 
  #-> exam must unique for each subject, academic session, name(exam type) in full set @ template.
  #eg. Final paper(exam_type) of subject A(subject) for session Jan-Jun2013(academic session) - can EXIST only ONCE (template @ full set).
  
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
  
  def render_full_name
    (Exam::EXAMTYPE.find_all{|disp, value| value == name}).map {|disp, value| disp}
  end  
  
  def exam_name_date
    "#{render_full_name}"+" - "+"#{exam_on.strftime("%d-%B-%Y")}"
  end
  #10Apr2013
  
  def exam_name_subject_date
     "#{render_full_name}"+" - "+"#{subject.subject_list}"+" - "+"#{exam_on.strftime("%d %B %Y")}"# +"#{subject.parent.course_type}"
  end
  
  def exam_code_date_type
    if klass_id == 0
      "#{subject.code}"+" | "+"#{exam_on.strftime("%d %b %y")}"+" (#{name}-T)"
    else
      "#{subject.code}"+" | "+"#{exam_on.strftime("%d %b %y")}"+" (#{name})"
    end
  end
  
  def subject_date
    "#{subject.subject_list}"+" - "+"#{exam_on.strftime("%d %b %y")}"
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
    "#{render_full_name}"+" - Tahun "+set_year.to_s+", "+"#{subject.parent.course_type}"+" "+set_semester.to_s+" - "+"#{subject.subject_list}"+" - "+"#{exam_on.strftime("%d %B %Y")}"
     #  "#{name}"+" - Tahun "+set_year.to_s+", "+"#{subject.parent.course_type}"+" "+"#{subject.parent.code}"+" - "+"#{subject.subject_list}"+" - "+"#{exam_on.strftime("%d %B %Y")}"
  end
  
  #--12June2013
  
  def render_examtype
    (Exam::EXAMTYPE.find_all{|disp, value| value == name}).map {|disp, value| disp}
    #(Exam::EXAMTYPE.find_all{|disp, value| value == examtype}).map {|disp, value| disp}
  end
  
  def subject_and_examtype_of_exammaker
    #   "#{Subject.find(subject_id).subject_code_with_subject_name} - #{(Exammaker::EXAMTYPE.find_all{|disp, value| value == examtype}).map {|disp, value| disp}}"
    "#{Programme.find(subject_id).subject_list}"
  end
  
  def subject_of_exammaker
    "#{Subject.find(subject_id).subject_code_with_subject_name} - #{description}"  #exammaker.examination.subject_code_with_subject_name
  end
  
  def full_marks(exampaper_id)
      Examquestion.sum(:marks,:joins=>:exammakers, :conditions => ["exammaker_id=?", exampaper_id]).to_f
  end 
  
  def examtypename
     (Exam::EXAMTYPE.find_all{|disp, value| value == name}).map {|disp, value| disp}
  	#Exam::EXAMTYPE[("#{name}".to_i)-1][0].to_s	    #Exam::EXAMTYPE[("#{examtype}".to_i)-1][0].to_s	
  end
  
  #--12June2013
  
  #----------------Coded List----------------------------------- 
  EXAMTYPE = [
            #  Displayed       stored in db
               [ "Peperiksaan Pertengahan Semester",      "M" ],
               [ "Peperiksaan Akhir Semester",            "F" ],
               [ "Peperiksaan Ulangan",                   "R" ]
  ]

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
