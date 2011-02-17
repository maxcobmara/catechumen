class Position < ActiveRecord::Base
  
  has_many :subordinates, :class_name => 'Position', :foreign_key => 'parent_id'
  belongs_to :bosses, :class_name => 'Position', :foreign_key => 'parent_id'
  belongs_to :staffgrade, :class_name => 'Staffgrade', :foreign_key => 'staffgrade_id'
  belongs_to :staff

  validates_uniqueness_of :positioncode
  validates_presence_of :positioncode
  
  def self.find_main
    Position.find(:all, :condition => ['parent_id IS NULL'])
    @staff = Staff.find(@staff.position.staff_id);
   # @leaveforstaff = Leaveforstaff.find(@leaveforstaff.approval1_id);
  end
  
  def position_with_code
    "#{positioncode}  #{positionname}"
  end
  
  def people_assigned
    Position.find(:all, :select => "staff_id", :conditions => ["staff_id IS NOT ?", nil]).map(&:staff_id)
  end
  
  
  
  def self.search(search)
     if search
        @positions = Position.find(:all, :conditions => ['positionname ILIKE ?', "%#{search}%"])
       else
        @positions = Position.find(:all,  :order => :positioncode)
     end
  end
end
