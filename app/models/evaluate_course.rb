class EvaluateCourse < ActiveRecord::Base
  belongs_to :studentevaluate,   :class_name => 'Student',   :foreign_key => 'student_id'
  belongs_to :stucourse,         :class_name => 'Programme', :foreign_key => 'course_id'
  belongs_to :subjectevaluate,   :class_name => 'Programme',   :foreign_key => 'subject_id'
  belongs_to :staffevaluate,     :class_name => 'Staff',     :foreign_key => 'staff_id'
  
  validates_presence_of :evaluate_date, :course_id, :ev_obj, :ev_knowledge, :ev_deliver, :ev_content, :ev_tool, :ev_topic, :ev_work, :ev_note, :ev_assessment, :student_id 
  validate :validate_staff_or_invitation_lecturer_must_exist
  validates_presence_of :subject_id, :if => :trainer_is_staff?
  validates_presence_of :invite_lec_topic, :if => :trainer_invited?
  validates_uniqueness_of :staff_id, :scope =>[:subject_id, :student_id], :message => I18n.t("evaluate_course.evaluation_once")
  
  
  attr_accessor :is_staff
  
  def trainer_is_staff?
    !staff_id.blank?
  end
  
  def trainer_invited?
    !invite_lec.blank?
  end
  
  #8March2013
  def lecturer_subject_evaluate
    "#{lecturer_evaluate} | #{subject_evaluate} "
  end
  #8March2013
  
  def lecturer_evaluate
    if staffevaluate.blank?
      "-"
    else
      #staffevaluate.staff_name_with_title
      staffevaluate.name
    end
  end
  
  def lecturer_evaluate_icno
     if staffevaluate.blank?
       "-"
     else
       staffevaluate.formatted_mykad
     end
   end
   
   def lecturer_evaluate_rank
      if staffevaluate.blank?
        "-"
      else
        staffevaluate.position_for_staff
      end
    end
  
  def course_evaluate
    if stucourse.blank?
      "-"
    else
      stucourse.programme_coursetype_name
    end
  end
  
  def course_type_evaluate
     if stucourse.blank?
       "-"
     else
       stucourse.specialisation
     end
   end
  
  def subject_evaluate
    if subjectevaluate.blank?
      "-"
    else
      subjectevaluate.name
    end
  end
  
  def evaluate_detail
    "#{course_evaluate} | #{lecturer_evaluate} | #{subject_evaluate} "
  end
  
  def self.search(programmeid)
    find(:all, :conditions => ['course_id=?', programmeid], :order =>'staff_id, subject_id ASC')
  end
  
  def self.search2(programmeid, search)
    ec_ids=EvaluateCourse.search3(search).map(&:id)
    @evaluate_courses=EvaluateCourse.find(:all, :conditions => ['course_id=? and id IN(?)', programmeid, ec_ids])
  end
  
  def self.search3(search)
    if search
      staff_ids=Staff.find(:all, :conditions => ['name ILIKE(?)', "%#{search}%"]).map(&:id)
      subject_ids=Programme.find(:all, :conditions => ['(name ILIKE(?) or code ILIKE(?)) and course_type=?',"%#{search}%", "%#{search}%", "Subject"]).map(&:id)
      @evaluate_courses = EvaluateCourse.find(:all, :conditions => ['staff_id IN(?) or subject_id IN(?) or invite_lec ILIKE(?)', staff_ids, subject_ids, "%#{search}%"])
    end
  end
  
  private
    def validate_staff_or_invitation_lecturer_must_exist
      if (staff_id.nil? || staff_id.blank?) && (invite_lec.nil? || invite_lec.blank?)
        errors.add(I18n.t('evaluate_course.staff_id'), I18n.t('evaluate_course.staff_invitation_must_exist')) 
      end 
    end
  
  
end
