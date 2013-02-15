class Intake < ActiveRecord::Base
  belongs_to :programme
  has_many   :students
end
