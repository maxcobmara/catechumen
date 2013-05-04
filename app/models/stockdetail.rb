class Stockdetail < ActiveRecord::Base
   belongs_to :stock
   belongs_to :supplier, :foreign_key => 'supplier_id'
   
   has_many :usesupplies
 #  has_many :suppliers
   
  
   
   def ref_no
	stock.app_no 
    end
	
	 def stock_supplier
    if supplier.blank?
      "-"
    else
      supplier.item_details
    end
  end
   
   def balance_quantity
      quantity_order - quantity_approve
   end
end
