class AssetPlacement < ActiveRecord::Base
  belongs_to :asset, :foreign_key => 'asset_id'
  belongs_to :location
  belongs_to :staff
end
