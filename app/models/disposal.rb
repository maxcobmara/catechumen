class Disposal < ActiveRecord::Base
  
  validates_presence_of :asset_id, :currentvalue
  
  belongs_to :asset, :foreign_key => 'asset_id'
  
  belongs_to :asscd, :class_name => 'Asset', :foreign_key => 'asset_id'
  
  def self.find_main
     Asset.find(:all, :condition => ['asset_id IS NULL'])
   end 
end
