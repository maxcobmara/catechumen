class Staffclassification < ActiveRecord::Base
  belongs_to :staffgrade
  belongs_to :staffservescheme
  
  validates_uniqueness_of :staffgrade_id, :scope => :staffservescheme_id, :message => "This has already been created"
end
