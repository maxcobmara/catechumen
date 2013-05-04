class Timetable < ActiveRecord::Base
  
  validates_presence_of :classroom_id,:topic_id, :location_id, :staff_id, :start_at, :end_at
    belongs_to :klasstime, :class_name => 'Klass', :foreign_key => 'classroom_id'
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
      my_klass = Timetable.find(:all, :conditions => {:id => this_id}, :select => :classroom_id).map(&:classroom_id)
      item_klass = Klass.find(:all, :conditions => {:id => my_klass})
      Student.count(:all, :include => [:klasses], :conditions => ['klasses.id in (?)', item_klass])
    end

    def my_students
      this_id = id
      my_klass = Timetable.find(:all, :conditions => {:id => this_id}, :select => :classroom_id).map(&:classroom_id)
      item_klass = Klass.find(:all, :conditions => {:id => my_klass})
      Student.find(:all, :include => [:klasses], :conditions => ['klasses.id in (?)', item_klass])
    end

    def topic_for_timetable
      if topic.blank?
        "N/A"
      else
        topic.topic_subject
      end
    end
   


    def staff_details
      suid = staff_id.to_a
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
    
    def classroom_details
      suid = classroom_id.to_a
      exists = Klass.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if classroom_id == nil
        ""
      elsif checker == []
        "-"
      else
       klasstime.name
      end
    end
	
	  def subject_details
      suid = classroom_id.to_a
      exists = Klass.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if classroom_id == nil
        ""
      elsif checker == []
        "-"
      else
       klasstime.subject_klass
      end
    end
    
     
	
	
    
    
    def topic_details
      suid = topic_id.to_a
      exists = Topic.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if topic_id == nil
        ""
      elsif checker == []
        "-"
      else
       topic.name
      end
    end
    
    
    def class_time
    	 "#{classroom_stu} -  #{topic_class}"
    end
    
    def classroom_stu
    if classroom_id.blank?
      "-"
    else
      klasstime.name
    end
  end
  
  def topic_class
    if topic_id.blank?
      "-"
    else
      topic.topic_subject
    end
  end
end
