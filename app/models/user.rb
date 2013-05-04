require 'digest/sha1'

class User < ActiveRecord::Base
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
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  #validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  validates_format_of       :email,
                            :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                            :message => "Email Not Valid"

  has_and_belongs_to_many :roles
  belongs_to :staff
  belongs_to :student

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  #attr_accessible :login, :email, :name, :password, :password_confirmation, :isstaff, :staff_id, 
                  #:student_id
                  
  cattr_accessor :current_user

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
  
  def user_nama
    stid = staff_id.to_a
    suid = student_id.to_a
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
        staff.staff_name_with_title
      end
    end
 end

 def role_user
   if isstaff == TRUE
     "STAFF"
   else
     "STUDENT"
   end
 end

 #---------------Search--------------------------------------------------------------------------------

   def self.search(search)
     if search
       find(:all, :conditions => ['login ILIKE ?', "%#{search}%"])
     else
       find(:all)
     end
   end
  

