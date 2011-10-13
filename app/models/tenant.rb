class Tenant < ActiveRecord::Base
  belongs_to :location
  belongs_to :staff
  has_many :students
end
