class Position < ActiveRecord::Base
  
  
  has_many :commandant, :class_name => 'Sdicipline', :foreign_key => 'commandant_id'
  has_many :counsellor, :class_name => 'Sdicipline', :foreign_key => 'caunsellor_id' 
  has_many :hod, :class_name => 'Travelrequest', :foreign_key => 'hod_id'
  #has_many :approver1, :class_name => 'Ptdo', :foreign_key => 'approver_1'
  has_many :approver2, :class_name => 'Ptdo', :foreign_key => 'approver_2'
  has_many :warden, :class_name => 'Sdicipline', :foreign_key => 'warden_id'
  has_many :subordinates, :class_name => 'Position', :foreign_key => 'parent_id'
  has_many :editor, :class_name => 'Examquestion', :foreign_key => 'editor_id'
  has_many :checker, :class_name => 'Instructor', :foreign_key => 'check_qc'
  has_many :approverqc, :class_name => 'Examquestion', :foreign_key => 'approver_id'
  belongs_to :bosses, :class_name => 'Position', :foreign_key => 'parent_id'
  belongs_to :staffgrade, :class_name => 'Employgrade', :foreign_key => 'staffgrade_id'
  belongs_to :staff
  has_many :approvers,   :class_name => 'Topic',    :foreign_key => 'approvedby_id'
  has_many :approver, :class_name => 'leaveforstudents', :foreign_key => 'staff_id'
 
  validates_uniqueness_of :positioncode
  validates_presence_of :positioncode
  
  #before_save  :titleize_name

  #def titleize_name
  #  self.positionname = positionname.titleize
  #end
  
  def self.find_main
    Position.find(:all, :condition => ['parent_id IS NULL'])
    @staff = Staff.find(@staff.position.staff_id);
   # @leaveforstaff = Leaveforstaff.find(@leaveforstaff.approval1_id);
  end
  
  def position_with_code
    "#{positioncode} - #{positionname} - #{name_for_staff}"
  end
  
  def position_with_boss
    "#{positionname} - #{name_for_staff}"
  end
  
  def unit_staff_name
    "#{unit} - #{name_for_staff}"
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
  
  def title_details
      suid = staff_id.to_a
      exists = Staff.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if staff_id == nil
        ""
      elsif checker == []
        "-"
      else
        staff.title_for_staff
      end
    end
  
    def name_for_staff
       if staff.blank?
         "-"
       else
         staff.staff_name_with_title
       end
     end
     
  def title_details
         suid = staff_id.to_a
         exists = Staff.find(:all, :select => "id").map(&:id)
         checker = suid & exists

         if staff_id == nil
           ""
         elsif checker == []
           "-"
         else
           staff.title_for_staff
         end
    end

  
  def self.search(search)
     if search
        @positions = Position.find(:all, :conditions => ['positionname ILIKE ?', "%#{search}%"])
       else
        @positions = Position.find(:all,  :order => :positioncode)
     end
  end
end
