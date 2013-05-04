class EvaluateCoach < ActiveRecord::Base
	
	before_save :varmyass
	validates_presence_of :evaluate_date
	
  #links to Model programme
  belongs_to :course_coach, :class_name => 'Programme',  :foreign_key => 'course_id'
  
  #links to Model staff
  belongs_to :staffcoachev,  :class_name => 'Staff',  :foreign_key => 'staff_id'
  
   #Link to Model subject
  belongs_to :subject,  :foreign_key => 'subject_id'
  
  #Link to Model klass
   belongs_to :klass,  :foreign_key => 'class_id'
   
   def varmyass
    self.result	= evaluatecalculate
  end
   
   def evaluatecalculate
   	  intro_plan + intro_abm + intro_att + intro_title + intro_obj +
   	  intro_ref + intro_exp + d_dev + d_interest + d_control +
   	  d_habit + d_emp + d_class + d_inv + d_abm + d_knowledge +
   	  sum_rev + sum_chance + q_rangka + q_merangkumi + q_tujukan +
   	  q_soalan + q_bina + q_future + q_time
   end
   
   def result_eva
     if result < 60
       "Tidak"
     else
       "Ya"
     end
   end
   
   def status_eva
      if result < 60
        "Gagal"
      else
        "Lulus"
      end
    end
  
    def programme_details
      suid = course_id.to_a
      exists = Programme.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if course_id == nil
        ""
      elsif checker == []
        "-"
      else
        course_coach.programme_with_specialisation
      end
    end 
  
end
