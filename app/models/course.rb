class Course < ActiveRecord::Base
  has_many :subjects, :class_name => 'Course', :foreign_key => 'parent_id'
  belongs_to :maincourse, :class_name => 'Course', :foreign_key => 'parent_id'
  
  belongs_to :admin, :class_name => 'Staff', :foreign_key => 'staff_id'
  
  belongs_to :staff
  
  validates_presence_of :coursecode, :name
  
  def self.find_main
      Course.find(:all, :conditions => ['parent_id IS NULL'])
  end
  
end
