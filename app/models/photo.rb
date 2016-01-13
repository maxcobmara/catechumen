class Photo < ActiveRecord::Base
  
  #belongs_to :page - refer body (page)
  validate :valid_for_removal
    
  has_attached_file :diagram,
                    :url => "/assets/images/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/images/:id/:style/:basename.:extension"
  validates_attachment_size :diagram, :less_than => 5.megabytes, :message => I18n.t('photo.exceed_file_size')
  validates_attachment_content_type :diagram, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"], :message => I18n.t('photo.wrong_file_format')
  

  def valid_for_removal
    #Page.find(1).body.include?(Photo.find(1).diagram_file_name)
    image_exist=0
    bodies=Page.all.map(&:body)
    for body in bodies
      if body.include?(diagram_file_name.gsub(" ", "%20") || body.include?(diagram_file_name))
        image_exist=1
      end
    end
    if image_exist==1
      return false
    else
      return true
    end
  end
  
end
