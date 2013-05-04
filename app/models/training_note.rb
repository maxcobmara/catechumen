class TrainingNote < ActiveRecord::Base
  belongs_to :topic
  belongs_to :timetable
  
  attr_accessible :document, :title, :version, :release
  
 #has_attached_file :document
 #validates_attachment_content_type :document, :content_type => ['application/pdf', 'application/msword','application/msexcel','image/png','text/plain'],
 #                       :storage => :file_system,
  #                      :message => "Invalid File Format" 
 #validates_attachment_size :document, :less_than => 5.megabytes
 
 
                   
 has_attached_file :document
  validates_attachment_content_type :document, :content_type => ['application/pdf', 'application/msword','application/msexcel','image/png','text/plain'],
                         :storage => :file_system,
                         :message => "Invalid File Format" 
  validates_attachment_size :document, :less_than => 5.megabytes

#validates_attachment_presence :document

 def bil
     v=1
  end
end
