class Stockcard < ActiveRecord::Base
  belongs_to :stock
  belongs_to :supplier
end
