class Addsupplier < ActiveRecord::Base
  belongs_to :supplier
  
  def line_item_value
    quantity * unitcost
  end
  
  def boo
    "ba"
  end
end
