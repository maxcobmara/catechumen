class Trainingnote < ActiveRecord::Base
  belongs_to :topic
  belongs_to :timetable
  
 #---------------------AttachFile------------------------------------------------------------------------
  has_attached_file :data
  validates_attachment_content_type :data, :content_type => ['application/pdf',  'application/msword','application/msexcel','image/png','text/plain'],
                        :storage => :file_system,
                        :message => "Invalid File Format" 
 validates_attachment_size :data, :less_than => 5.megabytes


end
