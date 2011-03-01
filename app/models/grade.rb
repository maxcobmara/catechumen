class Grade < ActiveRecord::Base
  
  validates_presence_of :student_id, :subject_id
  
  #Link to Model student
   belongs_to :studentgrade, :class_name => 'Student', :foreign_key => 'student_id'
   
  #Link to Model subject
    belongs_to :subjectgrade, :class_name => 'Subject', :foreign_key => 'subject_id'
    
    
    def total_per
      Score.sum(:weightage, :conditions => ["grade_id = ?", id])
    end
    
    def total_formative
      Score.sum(:score, :conditions => ["grade_id = ?", id])
    end
    
    def total_summative
      if exam1marks = 0
        0
      else
        (exam1marks * examweight)/100
      end
    end
    
    def finale
      ((exam1marks * examweight)/100) + ((total_formative * (100 - examweight)/100))
    end
    
    def grade_it
      if finale < 40
        "F"
      elsif finale < 50
        "D"
      elsif finale < 75
        "C"
      elsif finale < 90
        "B"
      else
        "A"
      end
        
    end
    
    
    
    
GRADE = [
  #  Displayed       stored in db
    [ "75% - A","1" ],
    [ "60% - B","2" ],
    [ "55% - C", "3" ],
    [ "35% - D", "4" ],
    [ "<34% - F", "5" ]

]

E_TYPES = [
    #  Displayed       stored in db
      [ "Clinical Work","1" ],
      [ "Assignment","2" ],
      [ "Project", "3" ],
      [ "Clinical Report", "4" ],
      [ "Test", "5" ],
      [ "Exam", "6" ],
      

]


# code for repeating field score
# ---------------------------------------------------------------------------------
 has_many :scores, :dependent => :destroy
 
 def new_score_attributes=(score_attributes)
   score_attributes.each do |attributes|
     scores.build(attributes)
   end
 end
 
 after_update :save_scores
 
 def existing_score_attributes=(score_attributes)
   scores.reject(&:new_record?).each do |score|
     attributes = score_attributes[score.id.to_s]
     if attributes
       score.attributes = attributes
     else
       scores.delete(score)
     end
   end
 end
 
 def save_scores
   scores.each do |score|
     score.save(false)
   end
 end
end
