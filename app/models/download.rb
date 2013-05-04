class Download < ActiveRecord::Base
  belongs_to :staff
  has_attached_file :document
  validates_attachment_content_type :document, :content_type => ['application/pdf', 'application/msword','application/msexcel','image/png','text/plain'],
                                    :storage => :file_system,
                                    :message => "Invalid File Format" 
  validates_attachment_size :document, :less_than => 5.megabytes
  
   before_save  :titleize_doc_group

    def titleize_doc_group
      self.doc_group = doc_group.upcase
    end
   
  def bil
      v=1
   end
end
