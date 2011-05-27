class Traveldetail < ActiveRecord::Base
  belongs_to :travelclaimrequest, :foreign_key => 'travelclaimrequest_id'
end
