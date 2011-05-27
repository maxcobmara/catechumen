class Employgrade < ActiveRecord::Base
  has_many :staffs, :class_name => 'Staffs', :foreign_key => 'staffgrade_id'
  has_many :staffgrades, :class_name => 'Positions', :foreign_key => 'staffgrade_id'
  
  has_many :staffemploygrades
  has_many :staffemployschemes, :through => :staffemploygrades
  
  validates_uniqueness_of :name, :scope => :group_id
  
  def booboo
    (Employgrade::GROUP.find_all{|disp, value| value == group_id}).map {|disp, value| disp}
  end
  
  def name_and_group
    "#{name}  (#{booboo})"
  end
  
  
  GROUP = [
       [ "Pengurusan & Professional", 1 ],
       [ "Sokongan", 2 ],
       [ "Bersepadu", 4 ]
  ]
end
