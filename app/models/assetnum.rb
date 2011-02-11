class Assetnum < ActiveRecord::Base
   belongs_to :asset
   validates_presence_of :assetnumname
end
