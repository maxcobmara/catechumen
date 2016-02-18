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

  #validates_presence_of     :isstaff, :message => "Please select staff or student"    #added 15July2013
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
      #timetableids = WeeklytimetableDetail.find(:all, :conditions =>['topic IN(?) and id IN(?)',topicids2,timetable_in_trainingnote]).map(&:id)
      #Use below instead & ignore training note -> copy above accordingly 4 those notes selection related
      timetableids = WeeklytimetableDetail.find(:all, :conditions =>['topic IN(?)',topicids2]).map(&:id)
      return timetableids
    end
  end

  def classes_taughtby
    classes_ids = WeeklytimetableDetail.find(:all, :conditions => ['lecturer_id=?',staff.id]).map(&:id)
    if classes_ids.is_a? Array
      return classes_ids
    else
      return []
    end
  end
  
  #use in - auth_rules(examquestion) - return [programme_id] for academician
  def lecturers_programme
    mypost = Position.find(:first, :conditions => ['staff_id=?',staff_id])
    myunit = mypost.unit
    postbasics=['Pengkhususan', 'Pos Basik', 'Diploma Lanjutan']
    post_prog=Programme.find(:all, :conditions => ['course_type IN(?)', postbasics])
    dip_prog=Programme.find(:all, :conditions => ['course_type=?', 'Diploma']).map(&:name)
    if dip_prog.include?(myunit)
      programmeid=Programme.roots.find(:all, :conditions => ['name=?', myunit]).map(&:id)
    else
      if myunit=="Pengkhususan" && roles.map(&:authname).include?("programme_manager")
        programmeid=post_prog.map(&:id)
      elsif postbasics.include?(myunit)
        post_prog.map(&:name).each do |pname|
          @programmeid=Programme.roots.find(:all, :conditions => ['name=?', pname]) if mypost.tasks_main.include?(pname).pluck(&:id)
        end
        programmeid=@programmeid
      else
        programmeid=0 #default val for admin, common_subjects lecturer too
      end
    end
    programmeid
  end
  
  #####
  def admin_unitleaders_thumb
    ############
    mypost = Position.find(:first, :conditions => ['staff_id=?', userable_id])
    myunit = mypost.unit
    mythumbid = userable.thumb_id
    iamleader=Position.am_i_leader(userable_id)
    if iamleader== true   #check by roles
      thumbs=Staff.find(:joins => :positions, :conditions => ['staffs.thumb_id!=? and unit=?', 5328, 'Teknologi Maklumat']).pluck(&:thumb_id)
#Staff.joins(:positions).where('staffs.thumb_id!=? and unit=?', mythumbid, myunit).pluck(:thumb_id)
    else #check by rank / grade
      leader_staffid=Position.unit_department_leader(myunit).id   #return Staff(id) record ofunit/dept leader
      @head_thumb_ids=[]
      
      #academic programmes-start
      postbasics=['Pengkhususan', 'Pos Basik', 'Diploma Lanjutan']
      dip_prog=Programme.find(:all, :conditions =>['course_type=?', 'Diploma']).map(&:name)
      post_prog=Programme.find(:all, :conditions => ['course_type=?', postbasics]).map(&:name)
      commonsubject=Programme.find(:all, :conditions=> ['course_type=?', 'Commonsubject']).map(&:name).uniq
      #temp-rescue - make sure this 2 included in Programmes table @ production svr as commonsubject type
      etc_subject=['Sains Tingkahlaku', 'Anatomi & Fisiologi']
      #academic programmes-end 
      
      if leader_staffid==userable_id #when current user is unit/department leader
        thumbs=Staff.find(:joins => :positions, :conditions => ['staffs.thumb_id!=? and unit=?', 5328, 'Teknologi Maklumat']).pluck(&:thumb_id)
#Staff.joins(:positions).where('staffs.thumb_id!=? and unit=?', mythumbid, myunit).pluck(:thumb_id)
        #when current user is Pengarah, above shall collect all timbalans thumb id plus academicians leader (Ketua Program)
        if userable_id==Position.roots.first.staff_id
          academic_programmes=dip_prog+post_prog+commonsubject
          academic_programmes.each do |prog|
            @head_thumb_ids << Position.unit_department_leader(prog).thumb_id if Position.find(:all, :conditions =>['staff_id is not null and unit=?', prog]).count > 0 #staff_id must exist 
          end
          thumbs+=@head_thumb_ids
        end
      else 
        #when superior for current user is Pengarah, then she must be one of timbalans-"Ketua Unit Pengurusan Tertinggi"
        if leader_staffid==Position.roots.first.staff_id 
          if mypost.name.include?("Pengurusan") #Timbalan Pengarah (Pengurusan)
            #management units
            mgmt_units= Position.find(:all, :conditions => ['staff_id is not null and unit is not null and unit!=? and unit not in (?) and unit not in (?) and unit not in (?) and unit not in (?)', '', dip_prog, commonsubject, postbasics, etc_subject]).map(&:unit).uniq
            mgmt_units.each do |department|
              @head_thumb_ids << Position.unit_department_leader(department).thumb_id unless Position.unit_department_leader(department).nil?
            end
            thumbs=@head_thumb_ids
          else #other timbalans
            thumbs=[]
          end
        else   
          thumbs=[]
        end
      end
    end
    thumbs
    ############
  end
  
  #use in - auth_rules(staff attendance)
  def unit_members_thumb
    Staff.find(:all, :conditions=> ['id IN?', unit_members]).map(&:thumb_id).compact #[5658]
  end
     
  ###Use in Ptdo(for use in auth_rules & Edit pages (approve)) - start
  def unit_members#(current_unit, current_staff, current_roles)
    #Academicians & Mgmt staff : "Teknologi Maklumat", "Perpustakaan", "Kewangan & Akaun", "Sumber Manusia","logistik", "perkhidmatan" ETC.. - by default staff with the same unit in Position will become unit members, whereby Ketua Unit='unit_leader' role & Ketua Program='programme_manager' role.
    #Exceptional for - "Kejuruteraan", "Pentadbiran Am", "Perhotelan", "Aset & Stor" (subunit of Pentadbiran), Ketua Unit='unit_leader' with unit in Position="Pentadbiran" Note: whoever within these unit if wrongly assigned as 'unit_leader' will also hv access for all ptdos on these unit staff
    
    current_staff=staff
    exist_unit_of_staff_in_position = Position.find(:all, :conditions => ['unit is not null and staff_id is not null']).map(&:staff_id).uniq
    if exist_unit_of_staff_in_position.include?(current_staff)   
      
      current_unit=staff.position.unit #staff.positions.first.unit
      #replace current_unit value if academician also a Unit Leader (23)
      #current_roles=User.where(userable_id: userable_id).first.roles.map(&:name) ##"Unit Leader" #userable.roles.map(&:role_id) 
      current_roles=roles.map(&:name)
      current_unit=unit_lead_by_academician if current_roles.include?("Unit Leader") && Programme.roots.map(&:name).include?(current_unit)
      
      if current_unit=="Pentadbiran"
        unit_members = Position.find(:all, :conditions => ['unit=? OR unit=? OR unit=? OR unit=?', "Kejuruteraan", "Pentadbiran Am", "Perhotelan", "Aset & Stor"]).map(&:staff_id).uniq-[nil]+Position.find(:all, :conditions => ['unit=?', current_unit]).map(&:staff_id).uniq-[nil]
      elsif ["Teknologi Maklumat", "Pusat Sumber", "Kewangan & Akaun", "Sumber Manusia"].include?(current_unit) || Programme.roots.map(&:name).include?(current_unit)
        unit_members = Position.find(:all, :conditions => ['unit=?', current_unit]).map(&:staff_id).uniq-[nil]
      else #logistik & perkhidmatan inc."Unit Perkhidmatan diswastakan / Logistik" or other UNIT just in case - change of unit name, eg. Perpustakaan renamed as Pusat Sumber
        unit_members = Position.find(:all, :conditions => ['unit ILIKE(?)', "%#{current_unit}%"]).map(&:staff_id).uniq-[nil] 
      end
    else
      unit_members = []#Position.find(:all, :conditions=>['unit=?', 'Teknologi Maklumat']).map(&:staff_id).uniq-[nil]
    end
    unit_members   #collection of staff_id (member of a unit/dept) - use in model/user.rb (for auth_rules)
    #where('staff_id IN(?)', unit_members) ##use in ptdo.rb (controller - index)
  end    
  
  def same_programme
    current_staff=staff
    unit=staff.position.unit
    if Programme.roots.map(&:name).include?(unit)
      course_id = Programme.where('name=? and ancestry_depth=?', unit,0).first.id
    elsif ["Pengkhususan", "Pos Basik", "Diploma Lanjutan"].include?(unit)
      main_task_first = userable.positions.first.tasks_main
      prog_name_full = main_task_first.scan(/Diploma Lanjutan (.*)/)[0][0].strip if ["Diploma Lanjutan"].include?(unit)    #main_task_first[/Diploma Lanjutan \D{1,}/]  
      prog_name_full = main_task_first.scan(/Pos Basik (.*)/)[0][0].strip if ["Pos Basik"].include?(unit)                            #main_task_first[/Pos Basik \D{1,}/]
      prog_name_full = main_task_first.scan(/Pengkhususan (.*)/)[0][0].strip if ["Pengkhususan"].include?(unit)            #main_task_first[/Pengkhususan \D{1,}/] 
      if prog_name_full.include?(" ")  #space exist, others may exist too
        a_rev=prog_name_full.gsub!(/[^a-zA-Z]/," ")   #in case a consist of comma, etc 
        prog_name=a_rev.split(" ")[0] #intake_desc=group
      else
        prog_name=prog_name_full
      end
      course_id = Programme.where('name ILIKE(?)', "%#{prog_name}%").first.id
    end 
    course_id
  end

                                                    
  #####

  named_scope :all
  named_scope :approval,  :conditions =>  ["student_id IS? AND staff_id IS ?", nil, nil]
  named_scope :staff,     :conditions =>  ["student_id IS? AND staff_id IS NOT ?", nil, nil]
  named_scope :student,   :conditions =>  ["student_id IS NOT ? AND staff_id IS ?", nil, nil]


  FILTERS = [
    {:scope => "all",       :label => I18n.t('login.all')},
    {:scope => "approval", :label => I18n.t('login.verify')},
    {:scope => "staff",     :label => I18n.t('login.staff')},
    {:scope => "student",   :label => I18n.t('login.student')}
    ]




end
