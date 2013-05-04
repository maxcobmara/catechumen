class Disposal < ActiveRecord::Base
  
  validates_presence_of :asset_id, :currentvalue
  
  belongs_to :asset
  
  
 # def age
 #   Date.today - @asset.purchasedate
 # end
  
  def depreciation_value
    @asset.purchaseprice - currentvalue
  end 
  
  def depreciation_percent
    ((@asset.purchaseprice - currentvalue)/@asset.purchaseprice)*100
  end
  
  def self.find_main
     Asset.find(:all, :condition => ['asset_id IS NULL'])
   end 
   
   def assetcode_details
     suid = asset_id.to_a
     exists = Asset.find(:all, :select => "id").map(&:id)
     checker = suid & exists

     if asset_id == nil
       ""
     elsif checker == []
       "-"
     else
       asset.assetcode
     end
   end
   
    def typename_details
      suid = asset_id.to_a
      exists = Asset.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if asset_id == nil
        ""
      elsif checker == []
        "-"
      else
        asset.typename
      end
    end
    
    def name_details
      suid = asset_id.to_a
      exists = Asset.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if asset_id == nil
        ""
      elsif checker == []
        "-"
      else
        asset.name
      end
    end
    
    def modelname_details
      suid = asset_id.to_a
      exists = Asset.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if asset_id == nil
        ""
      elsif checker == []
        "-"
      else
        asset.modelname
      end
    end
    
    def quantity_details
      suid = asset_id.to_a
      exists = Asset.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if asset_id == nil
        ""
      elsif checker == []
        "-"
      else
        asset.quantity
      end
    end
    
    def purchasedate_details
      suid = asset_id.to_a
      exists = Asset.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if asset_id == nil
        ""
      elsif checker == []
        "-"
      else
        asset.purchasedate
      end
    end
    
     def purchaseprice_details
        suid = asset_id.to_a
        exists = Asset.find(:all, :select => "id").map(&:id)
        checker = suid & exists

        if asset_id == nil
          ""
        elsif checker == []
          "-"
        else
          asset.purchaseprice
        end
      end
end
