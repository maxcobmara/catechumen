class Straining < ActiveRecord::Base
  belongs_to :appraisal
   validates_presence_of :name
   
  # belongs_to :straining, :foreign_key => 'staff_id'
   
    def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
    end
end
