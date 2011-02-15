class Travelrequest < ActiveRecord::Base
   has_many :travelclaims, :foreign_key =>'travelrequest_id'
   belongs_to :staff
  
  #this works belongs_to :staff
  belongs_to :stafftravel,    :class_name => 'Staff',        :foreign_key => 'staff_id'
  belongs_to :treplace,       :class_name => 'Staff',         :foreign_key => 'replacement_id'
  belongs_to :hod,            :class_name => 'Staff',         :foreign_key => 'hod_id'
  
  #has_many :travel, :class_name => 'Travelclaim', :foreign_key => 'travelrequest_id'
  
  validates_presence_of :staff_id, :message => "is required"
  validates_presence_of :trcode, :destination, :purpose, :tstartdt, :treturndt
  
  def self.find_main
      Travelrequest.find(:all, :condition => ['staff_id IS NULL'])
  end
  
  def self.find_main
      Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
  
  def travel_request_key
    "#{trcode} for #{tstartdt} to #{destination} by #{staff.mykad_with_staff_name} "
  end
  
  #def self.choices_for_name_by_group_and_event(group_id, event_id)
  #     find(:all, :conditions => ['group_id = ? AND event_id = ?',
   #                               group_id, event_id]).
   #      map {|u| [u.name, u.id] }
   #  end
end
