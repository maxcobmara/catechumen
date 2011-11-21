class Event < ActiveRecord::Base
  has_event_calendar :start_at => 'Event Start', :end_at => 'Event End' # 31/10/2011 - for calendar_event
  belongs_to :staff, :foreign_key => 'createdby'
  
  validates_presence_of :eventname, :location, :start_at
  # validates_format_of   :participants, :officiated
  #                      :with => /^[a-zA-Z'` ]+$/, :message => "contains illegal characters"
  
  
  before_save  :titleize_eventname

  def titleize_eventname
    self.eventname = eventname.titleize
  end
  
  
  def self.search(search)
      if search
        find(:all, :conditions => ['eventname ILIKE ? or location ILIKE ?', "%#{search}%","%#{search}%"])
     else
      find(:all)
     end
   end
  
end
