class Addbook < ActiveRecord::Base
  has_many :suppliers, :class_name => 'Asset', :foreign_key => 'supplier_id'
  has_many :manufacturers, :class_name => 'Asset', :foreign_key => 'manufacturer_id'
  has_many :books,  :foreign_key => 'supplier_id'
  has_many :courses, :class_name => 'Ptcourse', :foreign_key => 'provider'
end
