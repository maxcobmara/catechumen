class Position < ActiveRecord::Base
  
  has_many :subordinates, :class_name => 'Position', :foreign_key => 'parent_id'
  belongs_to :bosses, :class_name => 'Position', :foreign_key => 'parent_id'
  belongs_to :staffgrade, :class_name => 'Employgrade', :foreign_key => 'staffgrade_id'
  belongs_to :staff

  validates_uniqueness_of :positioncode
  validates_presence_of :positioncode
  
  before_save  :titleize_name

  def titleize_name
    self.positionname = positionname.titleize
  end
  
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
    if staff_id == nil
      available_staff
    else
      available_staff - a
    end
  end
  
  def just_a_counter
    v=1
  end
  
  #---start-15 Aug 2012--Create excel file--------- 
  def count_no
    @positions = Position.find(:all,  :order => :positioncode)
    @positions.each_with_index do |position, index|
      if position.id == "#{id}".to_i
          @bil = index+1
      end
    end
    # ..."#{id}"  #compare using current record id (unique)
    @bil
  end
  
  def self.title_excel
    ["MAKLUMAT PERJAWATAN DI KOLEJ-KOLEJ LATIHAN KEMENTERIAN KESIHATAN MALAYSIA SEHINGGA #{Date.today.strftime('%d-%m-%Y')}"]
  end
  
  def self.title2_excel
    ["KOLEJ: KOLEJ SAINS KESIHATAN BERSEKUTU JOHOR BAHRU"]
  end
  
  def self.header_excel
		["BIL","KOD","JAWATAN","GRED JAWATAN","NAMA","NO K/P","TARIKH LAHIR","TARIKH LANTIKAN PERTAMA", "TARIKH KENAIKAN PANGKAT KE GRED SEKARANG","CATATAN*"]
  end
   
  def self.column_excel
		[:count_no,:positioncode, :positionname, {:staffgrade=> [:name]}, {:staff => [:name,:formatted_mykad,:cobirthdt,:appointdt,:posconfirmdate]}]
  end
  #---end-15 Aug 2012--Create excel file---------

  
  def self.search(search)
     if search
        @positions = Position.find(:all, :conditions => ['positionname ILIKE ?', "%#{search}%"])
       else
        @positions = Position.find(:all,  :order => :positioncode)
     end
  end
end
