class Travelrequest < ActiveRecord::Base
  has_one :travelclaimrequest
  belongs_to :staff
  
  #this works belongs_to :staff
  belongs_to :stafftravel,    :class_name => 'Staff',        :foreign_key => 'staff_id'
  belongs_to :treplace,       :class_name => 'Staff',         :foreign_key => 'replacement_id'
  belongs_to :hod,            :class_name => 'Position',         :foreign_key => 'hod_id'
  belongs_to :vehicleoffice,      :class_name => 'Officecar',         :foreign_key => 'asset_id'
  
  #has_many :travel, :class_name => 'Travelclaim', :foreign_key => 'travelrequest_id'
  
  validates_presence_of :staff_id, :message => "is required"
  validates_presence_of :destination, :purpose, :tstartdt, :treturndt
  
  has_many :traveldetails, :foreign_key => 'travelrequest_id', :dependent => :destroy
  accepts_nested_attributes_for :traveldetails#, :reject_if => lambda { |a| a[:travelday].blank? }#
  
  def self.find_main
      Travelrequest.find(:all, :condition => ['staff_id IS NULL'])
  end
  
  def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
  
  def short_descr
    purpose.split(" ").slice(0,2).join(" ")
  end
  
  def short_dest
    wc = (destination.scan(/\w+/).size)
    if wc < 2
      destination
    else
      a = destination.split(" ").slice(0)
      b = destination.split(" ").slice(wc-1)
      a + " " + b
    end
  end
  
  def startdate
    tstartdt.strftime("%d-%b-%Y")  
  end
  
  def returndate
     treturndt.strftime("%d-%b-%Y")  
   end
  
  

  
  #07/12/2011 - Shaliza fixed the error for positioname
  def position_details 
       suid = staff_id.to_a
       exists = Staff.find(:all, :select => "id").map(&:id)
       checker = suid & exists     
   
       if staff_id == nil
          "" 
        elsif checker == []
          "Position No Longer Exists" 
       else
         staff.position_for_staff
       end
  end
  
  def staffgrade_details 
       suid = staff_id.to_a
       exists = Staff.find(:all, :select => "id").map(&:id)
       checker = suid & exists     
   
       if staff_id == nil
          "" 
        elsif checker == []
          "Grade No Longer Exist" 
       else
         stafftravel.grade_for_staff
       end
  end
  
  def duration
    treturndt - tstartdt
  end
  
  def travel_request_key
    "#{short_descr} at #{short_dest} on #{startdate} untill #{returndate} "
  end
  
  def self.search(search)
    if search
      @travelrequest = Travelrequest.find(:all, :conditions => ['destination LIKE ?' , "%#{search}%"])
    else
     @travelRequest = Travelrequest.find(:all)
    end
  end
  
  TRANSPORT = [
        #  Displayed       stored in db
        [ "Own Car","1"],
        [ "Office Car","2"],
        [ "Others","3"],
        [ "Train","4"],
        [ "Flight","5"],
        [ "Public Car","6"]
        
  ]

 
end
