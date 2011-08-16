class Disposal < ActiveRecord::Base
  
  validates_presence_of :asset_id, :currentvalue
  
  belongs_to :asset
  
  
  def age
    Date.today - @asset.purchasedate
  end
  
  def depreciation_value
    @asset.purchaseprice - currentvalue
  end 
  
  def depreciation_percent
    ((@asset.purchaseprice - currentvalue)/@asset.purchaseprice)*100
  end
  
  def self.find_main
     Asset.find(:all, :condition => ['asset_id IS NULL'])
   end 
end
