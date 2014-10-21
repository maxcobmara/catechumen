class Stationery < ActiveRecord::Base
  validates_presence_of :category
  validates_uniqueness_of :category, :code
  
  has_many :stationery_adds, :foreign_key => 'stationery_id' , :dependent => :destroy
  accepts_nested_attributes_for :stationery_adds, :allow_destroy => true
  
  has_many :stationery_uses, :foreign_key => 'stationery_id', :dependent => :destroy
  accepts_nested_attributes_for :stationery_uses, :allow_destroy => true
  
  
  def current_quantity
    a = StationeryAdd.sum(:quantity, :conditions => ["stationery_id = ?", id])
    b = StationeryUse.sum(:quantity, :conditions => ["stationery_id = ?", id])
    a - b
  end
  
  def total_value
    sid = id
    cost = StationeryAdd.find(:all, :conditions => {:stationery_id => sid}, :select => "line_item_value")
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
