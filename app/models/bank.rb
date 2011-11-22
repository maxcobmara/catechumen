class Bank < ActiveRecord::Base
  has_many :bankaccounts
end
