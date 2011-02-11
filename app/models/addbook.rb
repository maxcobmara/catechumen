class Addbook < ActiveRecord::Base
  has_many :suppliers, :class_name => 'Asset', :foreign_key => 'supplier_id'
  has_many :books,  :foreign_key => 'supplier_id'
end
