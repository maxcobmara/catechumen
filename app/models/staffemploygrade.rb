class Staffemploygrade < ActiveRecord::Base
  
  belongs_to :staffemployscheme
  belongs_to :employgrade
end
