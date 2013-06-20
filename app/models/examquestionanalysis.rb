class Examquestionanalysis < ActiveRecord::Base
  belongs_to :exammakeranalysis
  belongs_to :examquestion
end
