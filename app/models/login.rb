require 'digest/sha1'

class Login < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 3..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  
  #validates_presence_of     :icno,     :within => 3..100         #hide 15July2013
  validates_numericality_of :icno,     :only_integer => true      #added 15July2013
  validates_length_of       :icno,     :is => 12, :message => "MyKad no is 12 characters"
  validates_uniqueness_of   :icno,     :message => "Your MyKad no already has a registered account"
  
  validates_presence_of     :isstaff, :message => "Please select staff or student"    #added 15July2013
  has_and_belongs_to_many :roles
  belongs_to :staff
  belongs_to :student

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  #attr_accessible :login, :email, :name, :password, :password_confirmation, :isstaff, :staff_id, 
                  #:student_id
                  
  cattr_accessor :current_login

  def role_symbols
    roles.map do |role|
      role.authname.to_sym
    end
  end


  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def login_nama
    stid = Array(staff_id)
    suid = Array(student_id)
    stexists = Staff.find(:all, :select => "id").map(&:id)
    suexists = Student.find(:all, :select => "id").map(&:id)
    staffchecker = stid & stexists
    studentchecker = suid & suexists
    
      if student_id == nil && staff_id == nil
        ""
      elsif staff_id == nil && studentchecker == []
        "Student No Longer Exists"
      elsif isstaff == true && staffchecker == []
        "Staff No Longer Exists"
      elsif isstaff == false
        " #{student.name} + (Student)"   
      else
        staff.name
      end 
  end
  
  def assigned_staff
    Login.find(:all, :select => "staff_id", :conditions => ["staff_id IS NOT ?", nil]).map(&:staff_id)
  end
  
  def topicdetails_of_programme
    unit_of_staff = staff.position.unit
    if Programme.roots.map(&:name).include?(unit_of_staff)==true
      programme_of_staff = Programme.find(:all, :conditions=>['name ILIKE(?) and ancestry_depth=?', "%#{unit_of_staff}%",0]).first
      descednts = programme_of_staff.descendants.map(&:id)
      topicids2 = Programme.find(:all, :conditions=>['(course_type=? or course_type=?) and id IN(?)', "Topic", "Subtopic", descednts]).map(&:id)
      topicdetailsids = Topicdetail.find(:all, :conditions=>['topic_code IN(?)', topicids2]).map(&:id)
      return topicdetailsids
    end
  end
  
  def timetables_of_programme
    unit_of_staff = staff.position.unit
    if Programme.roots.map(&:name).include?(unit_of_staff)==true
      programme_of_staff = Programme.find(:all, :conditions=>['name ILIKE(?) and ancestry_depth=?', "%#{unit_of_staff}%",0]).first
      descednts = programme_of_staff.descendants.map(&:id)
      topicids2 = Programme.find(:all, :conditions=>['(course_type=? or course_type=?) and id IN(?)', "Topic", "Subtopic", descednts]).map(&:id)
      timetable_in_trainingnote = Trainingnote.find(:all, :conditions => ['timetable_id IS NOT NULL']).map(&:timetable_id)
      timetableids = WeeklytimetableDetail.find(:all, :conditions =>['topic IN(?) and id IN(?)',topicids2,timetable_in_trainingnote]).map(&:id)
      return timetableids
    end
  end
  
  named_scope :all
  named_scope :approval,  :conditions =>  ["student_id IS? AND staff_id IS ?", nil, nil]
  named_scope :staff,     :conditions =>  ["student_id IS? AND staff_id IS NOT ?", nil, nil]
  named_scope :student,   :conditions =>  ["student_id IS NOT ? AND staff_id IS ?", nil, nil]


  FILTERS = [
    {:scope => "all",       :label => "All"},
    {:scope => "approval", :label => "Verify"},
    {:scope => "staff",     :label => "Staff"},
    {:scope => "student",   :label => "Student"}
    ]
  

  
end
