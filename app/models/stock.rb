class Stock < ActiveRecord::Base

before_save :save_my_vars
  
   belongs_to :applicant,  :class_name => 'Staff', :foreign_key => 'staff_id'
   belongs_to :approver,  :class_name => 'Staff', :foreign_key => 'approver_id'
   belongs_to :storeman,  :class_name => 'Staff', :foreign_key => 'storeman_id'
   
   belongs_to :stockname,  :class_name => 'Supplier', :foreign_key => 'supplier_id'
   
   belongs_to :itemno,  :class_name => 'Supplier', :foreign_key => 'item_no'
   
   has_many :supplies
   
   def save_my_vars
   self.app_no = (sv).to_s
  end
  
  def sv
      "PLAMM" + '/' +  (stock_no).to_s
  end
  
  def stock_no
    Stock.last.id + 1
  end
   
   has_many :stockdetails, :dependent => :destroy
   accepts_nested_attributes_for :stockdetails, :allow_destroy => true
   
    has_many :stockcards, :dependent => :destroy
    accepts_nested_attributes_for :stockcards, :allow_destroy => true
   
   STATUS = [
          #  Displayed       stored in db
          [ "Permohonan Baru",1 ],
          [ "Diluluskan",2 ],
          [ "Ditolak",3 ],
          [ "Dihantar",4 ],
          [ "Diterima",5 ],
          
    ]
    
     def bil
         v=1
      end
end
