class Image < ActiveRecord::Base
  
  belongs_to :page
    
  has_attached_file :diagram,
                    :url => "/assets/images/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/images/:id/:style/:basename.:extension"
                    
                    #may require validation
  
end
