class LessonPlan < ActiveRecord::Base
  belongs_to :topic
  
   attr_accessible :timing, :objective, :task, :tool
end
