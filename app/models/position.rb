class Position < ActiveRecord::Base
  
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_save :set_combo_code, :titleize_name
  has_ancestry :cache_depth => true

  belongs_to :staffgrade, :class_name => 'Employgrade', :foreign_key => 'staffgrade_id'
  belongs_to :staff
  belongs_to :postinfo
  
  validates_uniqueness_of :combo_code
  validates_presence_of   :name
  


  def titleize_name
    self.name = name.titleize
  end
  
  def self.find_main
    Position.find(:all, :condition => ['parent_id IS NULL'])
    @staff = Staff.find(@staff.position.staff_id);
   # @leaveforstaff = Leaveforstaff.find(@leaveforstaff.approval1_id);
  end
  
  def set_combo_code
    if ancestry_depth == 0
      self.combo_code = code
    else
      self.combo_code = parent.combo_code + "-" + code
    end
  end
  
  
  def position_with_code
    "#{code}  #{name}"
  end
  
  def people_assigned
    a = Array.new
    pid = self.staff_id
    a << pid
    available_staff = Position.find(:all, :select => "staff_id", :conditions => ["staff_id IS NOT ?", nil]).map(&:staff_id)
    if staff_id == nil
      available_staff
    else
      available_staff - a
    end
  end
  
  def just_a_counter
    v=1
  end
  
  def tree_nd
    if is_root?
      gls = ""
    else
      gls = "class=\"child-of-node-#{parent_id}\""
    end
    gls
  end
  
  def hod
  end
  
  #export excel section ---
  def totalpost
	  "#{postinfo.post_count}"
  end
  
  def occupied_post
    "#{Position.find(:all, :conditions=> ['postinfo_id=? AND staff_id IS NOT NULL',postinfo_id]).count}"
  end
  
  def available_post
    "#{totalpost.to_i-occupied_post.to_i}"
  end
  
  def hakiki
    "#{Position.find(:all, :conditions=> ['postinfo_id=? AND status=? AND staff_id IS NOT NULL',postinfo_id, 1]).count }"
  end
  
  def kontrak
    "#{Position.find(:all, :conditions=> ['postinfo_id=? AND status=? AND staff_id IS NOT NULL',postinfo_id, 2]).count}"
  end
  
  def kup
    "#{Position.find(:all, :conditions=> ['postinfo_id=? AND status=? AND staff_id IS NOT NULL',postinfo_id, 3]).count}"
  end
  
  STATUS = [
        #  Displayed       stored in db
        [ "Hakiki", 1],
        [ "Kontrak", 2],
        [ "KUP",3]
  ]
  
  
  def self.search(search)
     if search
        @positions = Position.find(:all, :conditions => ['name ILIKE ?', "%#{search}%"], :order => 'combo_code')
       else
        @positions = Position.find(:all,  :order => 'combo_code')
     end
  end
end
