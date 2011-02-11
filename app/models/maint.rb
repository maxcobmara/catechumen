class Maint < ActiveRecord::Base
   belongs_to :asset
   validates_presence_of :maintainer_id
   
end
