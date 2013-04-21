class Trainingnote < ActiveRecord::Base
  
  # befores, relationships, validations, before logic, validation logic, 
   #controller searches, variables, lists, relationship checking
   
  before_save :get_topic_id_from_timetable
  
  belongs_to :topic
  belongs_to :timetable
  
  has_attached_file :document,
                    :url => "/assets/notes/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/notes/:id/:style/:basename.:extension"
                    
  
  def get_topic_id_from_timetable
    if topic_id.blank? == true
      self.topic_id = timetable.topic_id
    end
  end
  
end
