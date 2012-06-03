class Stationery < ActiveRecord::Base
  validates_presence_of :category
  validates_uniqueness_of :category, :code
  
  has_many :addsuppliers, :foreign_key => 'supplier_id' , :dependent => :destroy
  accepts_nested_attributes_for :addsuppliers, :allow_destroy => true
  
  has_many :usesupplies, :foreign_key => 'supplier_id', :dependent => :destroy
  accepts_nested_attributes_for :usesupplies, :allow_destroy => true
  
  
  def current_quantity
    a = Addsupplier.sum(:quantity, :conditions => ["supplier_id = ?", id])
    b = Usesupply.sum(:quantity, :conditions => ["supplier_id = ?", id])
    a - b
  end
  
  def total_value
    sid = id
    cost = addsuppliers.find(:all, :conditions => {:supplier_id => sid}, :select => "line_item_value")
    if b == nil
      "No Account Registered"
    else 
      Bank.find(:all, :select => "long_name", :conditions => {:id => b}).map(&:long_name).to_s
    end
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
      @stationery = Stationery.find(:all, :conditions => ['category ILIKE ?', "%#{search}%"])
     else
      @stationery = Stationery.find(:all,  :order => :category)
     end
  end
end
