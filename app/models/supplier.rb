class Supplier < ActiveRecord::Base
  
  validates_presence_of :category
  
  has_many :addsuppliers, :dependent => :destroy
  accepts_nested_attributes_for :addsuppliers, :allow_destroy => true
  
  has_many :usesupplies, :dependent => :destroy
  accepts_nested_attributes_for :usesupplies, :allow_destroy => true
  
  
  def current_quantity
    a = Addsupplier.sum(:quantity, :conditions => ["supplier_id = ?", id])
    b = Usesupply.sum(:quantity, :conditions => ["supplier_id = ?", id])
    a - b
  end
  
  def set_row_color
    if maxquantity == nil || minquantity == nil
      '#FFFF00'
    elsif current_quantity > maxquantity
      'blue'
    elsif current_quantity < maxquantity && current_quantity > minquantity
      'green'
    else
      'red'
    end  
  end
  
  def self.search(search)
     if search
      @supplier = Supplier.find(:all, :conditions => ['category ILIKE ?', "%#{search}%"])
     else
      @Supplier = Supplier.find(:all,  :order => :category)
     end
  end
  
 
end
