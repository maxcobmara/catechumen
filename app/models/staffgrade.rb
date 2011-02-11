class Staffgrade < ActiveRecord::Base
  
  has_many :staffs
  
  validates_presence_of :sgcode, :sgname, :sglevel
  
  def self.find_main
    Staffgrades.find(:all, :condition => ['staffgrade_id IS NULL'])
  end
  
  
end
