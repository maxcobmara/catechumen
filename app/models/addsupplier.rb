class Addsupplier < ActiveRecord::Base
  belongs_to :stationery
  
  #attr_accessible :line_item_value
  attr_accessor :total
  
  def line_item_value
    quantity.to_i * unitcost.to_f
  end
  
  def total
    
  end
  
  def boo
    "ba"
  end
end
