class EvaluateCourse < ActiveRecord::Base
  belongs_to :studentevaluate,   :class_name => 'Student',   :foreign_key => 'student_id'
  belongs_to :stucourse,         :class_name => 'Programme', :foreign_key => 'course_id'
  belongs_to :subjectevaluate,   :class_name => 'Programme',   :foreign_key => 'subject_id'
  belongs_to :staffevaluate,     :class_name => 'Staff',     :foreign_key => 'staff_id'
  
  validates_presence_of :evaluate_date, :course_id, :subject_id, :ev_obj, :ev_knowledge, :ev_deliver, :ev_content, :ev_tool, :ev_topic, :ev_work, :ev_note#,:student_id #20Feb2013-staff_id added
  
  validate :validate_staff_or_invitation_lecturer_must_exist
  
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
  
  private
    def validate_staff_or_invitation_lecturer_must_exist
      if (staff_id.nil? || staff_id.blank?) && (invite_lec.nil? || invite_lec.blank?)
        errors.add(I18n.t('evaluate_course.staff_id'), I18n.t('evaluate_course.staff_invitation_must_exist')) 
      end 
    end
  
  
end
