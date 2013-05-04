class Scsession < ActiveRecord::Base
   belongs_to :counselling
   validates_presence_of :issue, :scsessiondt
end
