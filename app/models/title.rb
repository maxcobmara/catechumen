class Title < ActiveRecord::Base
  has_many :staffs

  
  validates_presence_of :titlecode, :name
  
  def self.find_main
    Titles.find(:all, :condition => ['title_id IS NULL'])
  end
  
end