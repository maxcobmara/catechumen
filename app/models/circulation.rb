class Circulation < ActiveRecord::Base
  belongs_to :document
  belongs_to :staff
   
#---------------------AttachFile------------------------------------------------------------------------
 has_attached_file :action,
                    :url => "/assets/documents/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/documents/:id/:style/:basename.:extension"
 #validates_attachment_content_type :data, 
                        #:content_type => ['application/pdf', 'application/msword','application/msexcel','image/png','text/plain'],
                        #:storage => :file_system,
                        #:message => "Invalid File Format" 
 validates_attachment_size :action, :less_than => 5.megabytes
 
end