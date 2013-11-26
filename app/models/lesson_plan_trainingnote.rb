class LessonPlanTrainingnote < ActiveRecord::Base
  belongs_to :lesson_plan
  belongs_to :trainingnote
end
