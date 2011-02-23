class Position < ActiveRecord::Base
  
  has_many :subordinates, :class_name => 'Position', :foreign_key => 'parent_id'
  belongs_to :bosses, :class_name => 'Position', :foreign_key => 'parent_id'
  belongs_to :staffgrade
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
    a = Array.new
    pid = self.staff_id
    a << pid
    available_staff = Position.find(:all, :select => "staff_id", :conditions => ["staff_id IS NOT ?", nil]).map(&:staff_id)
    if staff_id = nil
      available_staff
    else
      available_staff - a
    end
  end
  
  def just_a_counter
    v=1
  end
  
  
  
  def self.search(search)
     if search
        @positions = Position.find(:all, :conditions => ['positionname ILIKE ?', "%#{search}%"])
       else
        @positions = Position.find(:all,  :order => :positioncode)
     end
  end
end
