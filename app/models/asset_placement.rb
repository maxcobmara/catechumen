class AssetPlacement < ActiveRecord::Base
  belongs_to :asset
  belongs_to :location
  belongs_to :staff
end
