class Bank < ActiveRecord::Base
  has_many :bankaccounts
  validates_uniqueness_of :long_name
end
