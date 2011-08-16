class Cofile < ActiveRecord::Base
  
  validates_presence_of :name, :location, :owner_id#:cofileno, 
  
  belongs_to :owner,    :class_name => 'Staff', :foreign_key => 'owner_id' 
  belongs_to :borrower, :class_name => 'Staff', :foreign_key => 'staffloan_id' 
  
  has_many :documents, :foreign_key => 'file_id'
  has_many :sdiciplines, :foreign_key => 'cofile_id'
  
  #Link to Model Sdicipline
  has_many :file,       :class_name => 'Sdicipline', :foreign_key => 'cofile_id'
  has_many :counsellings
  
  def file_no_and_name
    "#{cofileno}  #{name}"
  end
  
  
  def owner_details
    suid = owner_id.to_a
    exists = Staff.find(:all, :select => "id").map(&:id)
    checker = suid & exists
    
    if owner_id == nil
      ""
    elsif checker == []
      "Staff No Longer Exists"
    else
      owner.mykad_with_staff_name
    end
  end
  
  def borrower_details
    suid = staffloan_id.to_a
    exists = Staff.find(:all, :select => "id").map(&:id)
    checker = suid & exists
    
    if staffloan_id == nil
      ""
    elsif checker == []
      "Staff No Longer Exists"
    else
      borrower.mykad_with_staff_name
    end
  end
   
  def self.find_main
   Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
   
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
 
 
end
