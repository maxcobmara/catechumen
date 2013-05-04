class Grade < ActiveRecord::Base
  
  validates_presence_of :student_id, :subject_id
  
 
   belongs_to :studentgrade, :class_name => 'Student', :foreign_key => 'student_id'  #Link to Model student
   
   belongs_to :subjectgrade, :class_name => 'Subject', :foreign_key => 'subject_id'  #Link to Model subject
    
    
    def total_per
      Score.sum(:weightage, :conditions => ["grade_id = ?", id])
    end
    
    def total_formative
      Score.sum(:marks, :conditions => ["grade_id = ?", id])
    end
    
    
   
    
    def total_summative
       (exam1marks / examweight)*100
    end
    
    def finale
      total_formative + exam1marks
    end
    
    def grade_it
      if finale < 60
        "Gagal"
      else
        "Lulus"
      end
    end
    
     def set_row_color
        if finale < 60
          'red'
        else
          'green'
        end
      end
    
      def just_a_counter
        v=1
      end
      
    def student_details
      suid = student_id.to_a
      exists = Student.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if student_id == nil
        ""
      elsif checker == []
        "Student No Longer Exists"
      else
        studentgrade.student_name_with_programme
      end
    end    
    
    def subject_details
      suid = subject_id.to_a
      exists = Subject.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if subject_id == nil
        ""
      elsif checker == []
        "Subject No Longer Exists"
      else
        subjectgrade.subject_code_with_subject_name
      end
    end
    
     def exam_paper_name
        suid = subject_id.to_a
        exists = Exammaker.find(:all, :select => "id").map(&:id)
        checker = suid & exists

        if subject_id == nil
          ""
        elsif checker == []
          "Exam Name No Longer Exists"
        else
          exam_name.exam_result
        end
      end
    
    
GRADE = [
  #  Displayed       stored in db
    [ " >60% - Lulus","1" ],
    [ "<59% - Gagal", "2" ],

]

E_TYPES = [
    #  Displayed       stored in db
      [ "Assignment","1" ],
      [ "Project", "2" ],
      [ "Practical Test", "3" ],
      [ "Test", "4" ],
      [ "Exam", "5" ],
      

]


# code for repeating field score
# ---------------------------------------------------------------------------------
has_many :scores, :dependent => :destroy
accepts_nested_attributes_for :scores, :reject_if => lambda { |a| a[:type_id].blank? }, :allow_destroy => true 

end
