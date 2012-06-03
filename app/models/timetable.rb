class Timetable < ActiveRecord::Base
  
  validates_presence_of :klass_id,:topic_id, :location_id, :staff_id, :start_at, :end_at
  belongs_to :klass     
  belongs_to :topic     
  belongs_to :staff     
  belongs_to :location
  
  has_many :trainingreports
  has_many :studentattendances
  has_many :students, :through => :studentattendances
  
  has_many :trainingnotes, :dependent => :destroy
   accepts_nested_attributes_for :trainingnotes, :reject_if => lambda { |a| a[:title].blank? }
  
  def student_count
    this_id = id
    my_klass = Timetable.find(:all, :conditions => {:id => this_id}, :select => :klass_id).map(&:klass_id)
    item_klass = Klass.find(:all, :conditions => {:id => my_klass})
    Student.count(:all, :include => [:klasses], :conditions => ['klasses.id in (?)', item_klass])  
  end 
  
  def my_students
    this_id = id
    my_klass = Timetable.find(:all, :conditions => {:id => this_id}, :select => :klass_id).map(&:klass_id)
    item_klass = Klass.find(:all, :conditions => {:id => my_klass})
    Student.find(:all, :include => [:klasses], :conditions => ['klasses.id in (?)', item_klass]) 
  end
                         
  def staff_details 
    suid = Array(staff_id)
    exists = Staff.find(:all, :select => "id").map(&:id)
    checker = suid & exists     

    if staff_id == nil
      "" 
    elsif checker == []
      "Staff No Longer Exists" 
    else
     staff.staff_name_with_position
    end
  end
  
  def tt_entry
    return klass.subject.subjectcode unless klass.blank? and klass.subject.blank?
  end
  
  def klass_subject_name
    return klass.subject.name unless klass.blank? and klass.subject.blank?
  end
end
