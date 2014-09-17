class Role < ActiveRecord::Base
  has_and_belongs_to_many :logins
  
  before_save  :underscore_name
  
  def underscore_name
    self.authname = name.parameterize.underscore
  end
end
