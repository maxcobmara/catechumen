class Mentor < ActiveRecord::Base
  belongs_to :staff
  
  validates_presence_of :staff_id, :message => "Can't Be Blank"
  
  has_many :mentees, :dependent => :destroy
  accepts_nested_attributes_for :mentees, :reject_if => lambda { |a| a[:student_id].blank? }, :allow_destroy => true  
  
  #def mentorstaff
  #   suid = staff_id
  #   Staff.find(:all, :select => "name", :conditions => {:id => suid}).map(&:name)
  # end
   
   def mentorstaff
      suid = staff_id.to_a
      exists = Staff.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if staff_id == nil
        ""
      elsif checker == []
        "Staff No Longer Exists"
      else
        staff.staff_name_with_title.upcase
      end
    end 
    
    def mentor_name
      suid = staff_id.to_a
      exists = Staff.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if staff_id == nil
        ""
      elsif checker == []
        "Staff No Longer Exists"
      else
        staff.staff_name_with_title
      end
    end
 
#-----------------------Search By Subject--------------------------------------
  def self.search(search)
  if search 
    if search != '0'
       @mentors = Mentor.find(:all, :conditions => ["staff_id=?", search ])
     else
        @mentors = Mentor.find(:all)
      end
  else
        @mentors = Mentor.find(:all)
      end
  end   
    
      
end
