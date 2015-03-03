class StationeryAdd < ActiveRecord::Base
  belongs_to :stationery
  
  validates_presence_of :document, :unitcost, :received, :quantity #, :lpono
  
  #attr_accessible :line_item_value
  attr_accessor :total
  
  def line_item_value
    quantity * unitcost
  end
  
  def total
    
  end
  
  def boo
    "ba"
  end
end
