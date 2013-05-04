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
     "#{name} (#{booboo})"
   end
   
   #27Feb2013-display total of annual leave
   def total_leave
     (Employgrade::ANNUAL_LEAVE.find_all{|disp, value| value == yearly_leave.to_i}).map {|disp, value| disp}
   end


   GROUP = [
        [ "Pengurusan & Professional", 1 ],
        [ "Sokongan", 2 ],
        [ "Bersepadu", 4 ]
   ]
   
   #27Feb2013-coded list for annual leave -28Feb2013 changed from yearly to annual
   ANNUAL_LEAVE = [
      ["30", 1],
      ["25", 2],
      ["20", 3]
  
  ]
end