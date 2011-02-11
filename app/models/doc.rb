class Doc < ActiveRecord::Base
  belongs_to :curriculum
  validates_presence_of :description
  
 
end
