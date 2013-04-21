class AssetDefect < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
   #controller searches, variables, lists, relationship checking
   
   belongs_to :asset
   belongs_to :reporter, :class_name => 'Staff', :foreign_key => 'reported_by'
   belongs_to :processor, :class_name => 'Staff', :foreign_key => 'processed_by'
   belongs_to :decisioner, :class_name => 'Staff', :foreign_key => 'decision_by'
   
   def asset_name
     asset.assetcode if asset
   end

   def asset_name=(assetcode)
     self.asset = Asset.find_by_assetcode(assetcode) unless assetcode.blank?
   end
  
  
end
