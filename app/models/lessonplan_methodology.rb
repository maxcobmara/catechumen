class LessonplanMethodology < ActiveRecord::Base
  
  belongs_to :lesson_plan,     :foreign_key => 'lesson_plan_id'
end
