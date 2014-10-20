class AssetDefect < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
   #controller searches, variables, lists, relationship checking
   
   belongs_to :asset#p, :class_name => 'Asset', :foreign_key => 'asset_id'
   belongs_to :reporter, :class_name => 'Staff', :foreign_key => 'reported_by'
   belongs_to :processor, :class_name => 'Staff', :foreign_key => 'processed_by'
   belongs_to :decisioner, :class_name => 'Staff', :foreign_key => 'decision_by'
   
   def asset_name
     asset.assetcode if asset
   end

   def asset_name=(assetcode)
     self.asset = Asset.find_by_assetcode(assetcode) unless assetcode.blank?
   end
   def owner
     31#Asset.find(:all, :conditions =>['assignedto_id=?', 31])
   end
   
   def reported_name
     reporter.name
   end
   
   def processor_name
     processor.try(:name)
   end
   
   def self.incharge_staffs
     defected_asset_ids = AssetDefect.all.map(&:asset_id)
     incharge_ids_of_defected = Asset.find(:all, :conditions=>['assignedto_id is not null AND id IN(?)',defected_asset_ids]).map(&:assignedto_id).uniq
     staff_ids=Staff.all.map(&:id)
     incharge_ids_of_defected2 = []
     incharge_ids_of_defected.each do |incharge| 
        incharge_ids_of_defected2 << incharge if staff_ids.include?(incharge) == true
     end
     incharge_ids_of_defected2
   end

end
