class Event < ActiveRecord::Base
  validates_presence_of :eventname, :location
 # validates_format_of   :participants, :officiated, :createdby,
  #                      :with => /^[a-zA-Z'` ]+$/, :message => "contains illegal characters"
  
  def self.search(search)
      if search
        find(:all, :conditions => ['eventname ILIKE ? or location ILIKE ?', "%#{search}%","%#{search}%"])
     else
      find(:all)
     end
   end
  
end
