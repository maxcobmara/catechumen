class Txsupplies < ActiveRecord::Base
  
  belongs_to :part
  validates_presence_of :quantity
  
   belongs_to :txsupplies, :foreign_key => 'staff_id'
   
    def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
    end
end
