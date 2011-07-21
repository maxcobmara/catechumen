class Assetcategory < ActiveRecord::Base
  
  has_many :assets, :foreign_key => 'category_id'
  
  has_many    :subs,    :class_name => 'Assetcategory', :foreign_key => 'parent_id'
  belongs_to  :parent,  :class_name => 'Assetcategory', :foreign_key => 'parent_id'

  
  ASSETTYPE = [
             #  Displayed       stored in db
             ["Harta",1],
             ["Inventory",2]
  ]
end
