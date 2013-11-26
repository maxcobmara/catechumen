class Answerchoice < ActiveRecord::Base
  belongs_to :examquestion, :foreign_key => 'examquestion_id'
end
