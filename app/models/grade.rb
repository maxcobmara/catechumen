class Grade < ActiveRecord::Base
  
  #Link to Model student
   belongs_to :studentgrade, :class_name => 'Student', :foreign_key => 'student_id'
   
   #Link to Model subject
    belongs_to :subjectgrade, :class_name => 'Subject', :foreign_key => 'subject_id'
    
GRADE = [
  #  Displayed       stored in db
    [ "75% - A","1" ],
    [ "60% - B","2" ],
    [ "55% - C", "3" ],
    [ "35% - D", "4" ],
    [ "<34% - F", "5" ]

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
