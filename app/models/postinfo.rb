class Postinfo < ActiveRecord::Base
  has_many :positions
  belongs_to :employgrade, :foreign_key => "staffgrade_id"
  
  def details_grade 
    "#{details}"+" - "+"#{employgrade.name}"
  end
end
