class Maint < ActiveRecord::Base
   belongs_to :asset
   belongs_to :maintainedby, :class_name => 'AddressBook', :foreign_key => 'maintainer_id'
   validates_presence_of :maintainer_id
   
end
