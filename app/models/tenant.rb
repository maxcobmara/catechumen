class Tenant < ActiveRecord::Base
  belongs_to :location
  belongs_to :staff
  belongs_to :student
end
