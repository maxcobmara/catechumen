class Assetcategory < ActiveRecord::Base
  
  has_many :assets, :foreign_key => 'category_id'
  has_many    :subs,    :class_name => 'Assetcategory', :foreign_key => 'parent_id'
  belongs_to  :parent,  :class_name => 'Assetcategory', :foreign_key => 'parent_id'

  
  ASSETTYPE = [
    #  Displayed       stored in db
       ["Harta",1],
       ["Inventory",2]
  ]
  
   def parent_details 
         suid = parent_id.to_a
         exists = Assetcategory.find(:all, :select => "id").map(&:id)
         checker = suid & exists     

         if parent_id == nil
            "" 
          elsif checker == []
            "-" 
         else
           parent.description
         end
    end
end
