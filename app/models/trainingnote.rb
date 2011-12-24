class Trainingnote < ActiveRecord::Base
  belongs_to :topic
  belongs_to :timetable
  
  has_attached_file :document,
                    :url => "/assets/notes/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/notes/:id/:style/:basename.:extension"
  
end
