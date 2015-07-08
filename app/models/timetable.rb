class Timetable < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  belongs_to :creator, :class_name => 'Staff', :foreign_key => 'created_by'
  before_destroy :valid_for_removal
  
  has_many :timetable_periods, :dependent => :destroy
  accepts_nested_attributes_for :timetable_periods, :allow_destroy => true#, :reject_if => lambda { |a| a[:start_at].blank? }

  #20March2013- weeklytimetables - newly added models..
  has_many :timetable_for_monthurs,   :class_name => 'Weeklytimetable', :foreign_key => 'format1'#, :dependent => :nullify
  has_many :timetable_for_friday,     :class_name => 'Weeklytimetable', :foreign_key => 'format2'#, :dependent => :nullify

  def self.search(search)
    if search
      @timetables = Timetable.find(:all, :conditions => ['code ILIKE(?) OR name ILIKE(?) OR description ILIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      @timetables = Timetable.all
    end
    @timetables
  end
  
  def timetable_in_use
    wts=Weeklytimetable.find(:all, :select => 'format1, format2')
    timetable_use=Array.new
    wts.each{|x|timetable_use << x.format1 << x.format2}
    timetable_use.uniq
  end
  
  #when in use, timetable is INVALID for removal, as well as its timetable_periods(no slot can be removed)
  def valid_for_removal
    if timetable_in_use.include?(id)
      return false
    else
      return true
    end
  end
  
  #WT published (submitted & approved)
  def timetable_activated 
    wts=Weeklytimetable.find(:all, :conditions =>['is_submitted is true and hod_approved is true'], :select => 'format1, format2')
    activated=Array.new
    wts.each{|x|activated << x.format1 << x.format2}
    if activated.uniq.include?(id)
      return true
    else
      return false
    end
  end
  
end
