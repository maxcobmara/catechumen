class Trainneed < ActiveRecord::Base
  
    belongs_to :staffs
    belongs_to :appraisal
   # validates_presence_of :name

   # belongs_to :trainneed, :foreign_key => 'staff_id'
   belongs_to :confirmedby, :class_name => 'Staff', :foreign_key => 'confirmedby_id'

     def self.find_main
       Staff.find(:all, :condition => ['staff_id IS NULL'])
     end
     
end
