class Staff < ActiveRecord::Base
  # acts_as_reportable
  before_save  :titleize_name

  def titleize_name
    self.name = name.titleize
  end
  
  has_and_belongs_to_many :messages
  has_and_belongs_to_many :documents
  
  has_attached_file :photo
  
 # validates_attachment_presence :photo
  #validates_attachment_size         :photo, :less_than => 150.kilobytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
 #---------------Validations------------------------------------------------
  validates_numericality_of :icno#, :kwspcode
  validates_length_of       :icno, :is =>12
  validates_presence_of     :icno, :name, :coemail
  validates_uniqueness_of   :icno, :coemail #:code #:fileno
  validates_format_of       :name, :with => /^[a-zA-Z'` ]+$/, :message => "Contains Illegal Characters" #add unwanted chars between bracket
  validates_presence_of     :cobirthdt, :addr #:poskod_id, :statecd, :country_cd
  #validates_length_of      :cooftelno, :is =>10
  #validates_length_of      :cooftelext, :is =>5
  validates_length_of       :addr, :within => 1..180, :too_long => "Address Too Long"
  validates_format_of       :coemail,
                            :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                            :message => "Not Valid"
 #-----------------------------------------------------------------------------------------------------------
  
  
#----------Link Foreign Key with other pages---------------------------------------------------

  has_many :books,        :foreign_key => 'receiver_id' 
  has_many :locations,    :class_name => 'Locations', :foreign_key => 'staffadmin_id'
  has_many :assigned,     :class_name => 'Assets', :foreign_key => 'assignedto_id'
  has_many :rxassets,     :class_name => 'Assets', :foreign_key => 'receiver_id'
  has_many :bulletins,    :foreign_key => 'postedby_id'
  has_many :sdiciplines,  :foreign_key => 'reportedby_id'
  has_many :strainings,   :foreign_key => 'staff_id'
  has_many :librarytransactions
  has_one  :position
  has_many :events,       :foreign_key => 'createdby'                                      #link to created by in events
  has_many :staffevaluate,  :class_name => 'evaluate_lecturer',     :foreign_key => 'staff_id'  
  has_many :staffcoachev,   :class_name => 'evaluate_coach',  :foreign_key => 'staff_id'  #link to created by in evaluate_coach
  
  # has_many :topics, :foreign_key => 'creator_id' 
  #has_many :curriculums, :foreign_key => 'staff_id'
  #has_many :txsuppliess, :foreign_key => 'staff_id'
  #has_many :bulletins, :foreign_key => 'staff_id'  seriously?!  theres no staff_id in this table!  
  # you also repeated this in line 66!!!!!   Now see the corresponding in bulletin.rb
  #has_many :assetloss, :foreign_key => 'staff_id'
  #has_many :evactivities, :foreign_key => 'staff_id'
 
  
  #-----------------belongs_to other page-----------------------------------------------------
  
  belongs_to :title, :class_name => 'Title', :foreign_key => 'titlecd_id'
  belongs_to :level,  :class_name => 'Qualification', :foreign_key => 'level_id'
  belongs_to :staffgrade, :class_name => 'Employgrade', :foreign_key => 'staffgrade_id'
  has_many   :ptdos #staff training
  #-------------display data for different table-----------------------------------------------
 
  #Link to model document
  has_many :documents,    :class_name => 'Documents', :foreign_key => 'stafffiled_id' 
  has_many :cc1s,         :class_name => 'Documents', :foreign_key => 'cc1staff_id' 
  has_many :cc2s,         :class_name => 'Documents', :foreign_key => 'cc2staff_id' 
  has_many :actiontaken,  :class_name => 'Documents', :foreign_key => 'action_by'
  
  #Link to model user
  has_many :users
  has_many :timetables
  
  has_many :approver1,        :class_name => 'Ptdo', :foreign_key => 'approver_1'
  has_many :replacementstaff, :class_name => 'Ptdo', :foreign_key => 'replacement_id'
  
  #Link to Model Stock
  has_many :applicant,  :class_name => 'Stock', :foreign_key => 'staff_id'
  has_many :approver,  :class_name => 'Stock', :foreign_key => 'approver_id'
  has_many :storeman,  :class_name => 'Stock', :foreign_key => 'storeman_id'
  
  #Link to Model TimetableEntry
  has_many :timetable,  :class_name => 'TimeTableEntry', :foreign_key => 'staff_id'
  
  #Link to model bulletin
  #has_many :bulletin, :class_name => 'bulletin', :foreign_key => 'postedby_id'  #posted by
  
  #Trainingrequest
  has_many :applicants, :class_name => 'Trainingrequest', :foreign_key => 'staff_id'
  has_many :approvers, :class_name => 'Trainingrequest', :foreign_key => 'approvedby_id'
  #has_many :trainingrequests
  
  #Link to model Residence
  #has_many :staff, :class_name => 'Residence', :foreign_key => 'staff_id'  
  #has_many :admin, :class_name => 'Residence', :foreign_key => 'staffadmin_id'
  
  #Link to model Appraisal                                                      
  has_many :appraised, :class_name => 'Appraisal', :foreign_key => 'staff_id'#, :dependant => :destroy
  has_many :ppp,       :class_name => 'Appraisal', :foreign_key => 'ppp_id'
  has_many :ppk,       :class_name => 'Appraisal', :foreign_key => 'ppk_id' 
  
  #Link to model AssetTrack
  has_many :staffinassettrack, :class_name => 'assettrack', :foreign_key => 'staff_id'
  has_many :isby,              :class_name => 'assettrack', :foreign_key => 'issuedby'
  has_many :assettrackreturn,  :class_name => 'assettrack', :foreign_key => 'returnedto'  
  
  #links to Model Cofile
  has_many :owners,    :class_name => 'Cofiles', :foreign_key => 'owner_id'
  has_many :borrowers, :class_name => 'Cofiles', :foreign_key => 'staffloan_id'
 
  
  #Link to model Sdicipline
  has_many :warden,     :class_name => 'Sdicipline', :foreign_key => 'warden_id' # reported_by
  has_many :counsellor, :class_name => 'Sdicipline', :foreign_key => 'caunsellor_id' # 
  
  #Link to Model Travelclaim
  has_many :travelcode,    :class_name => 'Travelclaim',      :foreign_key => 'travelrequest_id'
  has_many :hod,           :class_name => 'Travelclaim',      :foreign_key => 'hod_id'
  
  #Link to Model UseSupplier
  has_many :issuesupply,      :class_name => 'usesupply',   :foreign_key => 'issuedby'
  has_many :receivesupply,    :class_name => 'usesupply',   :foreign_key => 'receivedby'
  
  #Link to Model AddSupplier
  has_many :receivedby,      :class_name => 'addsupplier',   :foreign_key => 'received_by'
  
  #Link to Model BookingVehicle
  has_many :staffname,      :class_name => 'Bookingvehicle',   :foreign_key => 'applicant'
  has_many :approver,       :class_name => 'Bookingvehicle',    :foreign_key => 'approver_name'
  has_many :endorser,       :class_name => 'Bookingvehicle',    :foreign_key => 'endorse_name'
  has_many :driver,         :class_name => 'Bookingvehicle',      :foreign_key => 'driver_name'
  
  #Link to Model Topic
  has_many :creators,    :class_name => 'Topic',    :foreign_key => 'creator_id'
 
  
  
  #link to model Examquestion
  has_many :approver,   :class_name => 'Examquestion',   :foreign_key => 'approver_id' #approver name
  has_many :creator,    :class_name => 'Examquestion',   :foreign_key => 'creator_id'  #creator name
  has_many :editor,     :class_name => 'Examquestion',   :foreign_key => 'editor_id'   #editor name
  
  has_many :creatorpaper,    :class_name => 'Exammaker',   :foreign_key => 'creator_id'  #creator name
  
  
  #links to Model TravelRequest
  has_many :stafftravel,     :class_name => 'Travelrequest', :foreign_key => 'staff_id', :dependent => :destroy #staff name
  has_many :replacements,       :class_name => 'Travelrequest', :foreign_key => 'replacement_id' #replacement name
  has_many :hod,                :class_name => 'Travelrequest', :foreign_key => 'hod_id' #hod
  
  #links to Model Attendances
  has_many :attendingstaffs,        :class_name => 'Attendance', :foreign_key => 'staff_id'#, :dependent => :destroy #attendance staff name
  has_many :approvers, :class_name => 'Attendance', :foreign_key => 'approve_id' # approver name
  
  #links to Model Assetloss
   has_many :laststaff,        :class_name => 'Assetloss',   :foreign_key => 'lossstafflast_id' 
   has_many :hod,              :class_name => 'Assetloss',   :foreign_key => 'hod_id'
   has_many :enforce,          :class_name => 'Assetloss',   :foreign_key => 'newrule_id'
   has_many :officer,          :class_name => 'Assetloss',   :foreign_key => 'sio_id'
   
   #links to Model Message
   has_many :cc,        :class_name => 'Message', :foreign_key => 'cc_id'
    
  #links to Model Course
  has_many :admin,        :class_name => 'Course', :foreign_key => 'staff_id'
  
  #links to Model leaveforstaffs
   has_many :leave_applications, :class_name => 'Leaveforstaff', :foreign_key => 'staff_id'#, :dependent => :destroy
   has_many :replacements,       :class_name => 'Leaveforstaff', :foreign_key => 'replacement_id'
   has_many :seconders,          :class_name => 'Leaveforstaff', :foreign_key => 'approval1_id'
   has_many :approvers,          :class_name => 'Leaveforstaff', :foreign_key => 'approval2_id'
  
  #links to Model Analysis_Grade
  has_many :examiner, :class_name => 'AnalysisGrades', :foreign_key => 'staff_id'
    
  #links to Model Student
  has_many :approvedby, :class_name => 'Student', :foreign_key => 'approve_id'
  
  #links to Model Skt_Staff
  has_many :pyd, :class_name => 'Skt_staff', :foreign_key => 'pyd_id'
  has_many :ppp, :class_name => 'Skt_staff', :foreign_key => 'ppp_id'
  
  #links to Model bookingfacility
  has_many :staffbooked,   :class_name => 'Bookingfacility', :foreign_key => 'staff_id'
  has_many :approvebooked, :class_name => 'Bookingfacility', :foreign_key => 'approver_id'
  has_many :officer,       :class_name => 'Bookingfacility', :foreign_key => 'facility_officer'
  
  #links to Model Trainneeds
   has_many :staff_that_need_training, :class_name => 'Trainneed', :foreign_key => 'staff_id'
   has_many :training_managers, :class_name => 'Trainneed', :foreign_key => 'confirmedby_id'
   
   #links to Model Average Evaluate
   has_many :principal_name, :class_name => 'Averagelecturer', :foreign_key => 'pricipal_id'
   
   
#-------------Empty Field for Foreign Key Link------------------------
  has_many :downloads
  has_many :mentors
  has_many :courses
  has_many :sdiciplines
  has_many :attendances
  has_many :circulate_name, :class_name => 'Circulate', :foreign_key => 'cc_staff'
  has_many :instructor_name, :class_name => 'Instructor', :foreign_key => 'staff_id'
#--------------------------------------------------------------------------
  
  



#----------------------------code for repeating fields------------------------------------------  
 
  has_many :qualifications, :dependent => :destroy
  accepts_nested_attributes_for :qualifications, :reject_if => lambda { |a| a[:level_id].blank? }
  
  has_many :loans, :dependent => :destroy
  accepts_nested_attributes_for :loans, :reject_if => lambda { |a| a[:ltype].blank? }

  has_many :kins, :dependent => :destroy
  accepts_nested_attributes_for :kins, :reject_if => lambda { |a| a[:kintype_id].blank? }
  
  has_many :bankaccounts, :dependent => :destroy
  accepts_nested_attributes_for :bankaccounts, :reject_if => lambda { |a| a[:account_no].blank? }
  
  has_many :individu_courses, :dependent => :destroy
  accepts_nested_attributes_for :individu_courses, :reject_if => lambda { |a| a[:course_name].blank? }
 
  has_many  :vehicleregnos
  accepts_nested_attributes_for :vehicleregnos, :allow_destroy => true 
 
     
     
     
#--------------------Declerations----------------------------------------------------
  def age
    Date.today.year - cobirthdt.year
  end
 
  def formatted_mykad
    "#{icno[0,6]}-#{icno[6,2]}-#{icno[-4,4]}"
  end
  

  def mykad_with_staff_name
    "#{formatted_mykad}  #{name}"
  end

  def position_with_name   #this currenlt works with staff leave
      "#{title_for_staff} #{name}  (#{position.positionname})"
  end
  
  def staff_name_with_position
    "#{title_for_staff} #{name}  (#{position_for_staff})"
  end
  
  def staff_name_with_title
    "#{title_for_staff} #{name}"
  end
  
  def position_for_staff
    if position.blank?
      "-"
    else
      position.positionname
    end
  end
  
  def unit_for_staff
    if position.blank?
      "-"
    else
      position.unit
    end
  end
  
  def grade_for_staff
    if staffgrade.blank?
      "-"
    else
      staffgrade.name
    end
  end
  
  def title_for_staff # 14/12/2011 - Shaliza added code if title blank
    if title.blank?
      "-"
    else
      title.name
    end
  end
  
  def my_bank
    (Staff::BANK.find_all{|disp, value| value == bank }).map {|disp, value| disp}
  end
  
  def render_reports_to
    if position.blank? 
      ""
    elsif position.bosses.blank?
      "-"
    elsif position.bosses.staff.blank?
      "#{position.bosses.positionname}"
    else 
      "#{position.bosses.positionname} - #{position.bosses.staff.name}"
    end
  end
  
  
  def staff_positiontemp
    sid = staff.id
    spo = Position.find(:all, :select => "positionname", :conditions => {:staff_id => sid}).map(&:positionname)
    if spo == nil
      "NA"
    else 
      @staff.position.positionname
    end 
  end
  
  def staff_position
    sid = staff.id
    Position.find(:all, :select => "positionname", :conditions => {:staff_id => sid}).map(&:positionname)
  end
  
  
  
 

  def icno_with_staff_name
    "#{icno}  #{name}"
  end
  
 def bil
   v=1
  end
  

#------------------Coded Lists----------------------------------------- 
  MARITAL_STATUS = [
       #  Displayed       stored in db
       [ "Tidak Pernah Berkahwin",1 ],
       [ "Berkahwin",2 ],
       [ "Balu", 3 ],
       [ "Duda", 4],
       [ "Bercerai", 5 ],
       [ "Berpisah", 6 ],
       [ "Tiada Maklumat", 9 ]
  ]
     
  BLOOD_TYPE = [
      #  Displayed       stored in db
      [ "O",   "1" ],
      [ "O+",  "2" ],
	    [ "O-",  "3" ],
	    [ "A",   "4" ],
      [ "A+",  "5" ],
      [ "A-",  "6" ],
	    [ "B",   "7" ],
      [ "B+",  "8" ],
      [ "B-",  "9" ],
	    [ "AB",  "10" ],
	    [ "AB+", "11" ],
      [ "AB-", "12" ]
  ]
         
  STATECD = [
      #  Displayed       stored in db
      [ "Johor",         1 ],
      [ "Kedah",    2 ],
      [ "Kelantan", 3 ],
      [ "Melaka", 4],
      [ "Negeri Sembilan", 5 ],
      [ "Pahang", 6 ],
      [ "Pulau Pinang", 7 ],
      [ "Perak", 8 ], 
      [ "Perlis", 9 ],
      [ "Selangor", 10 ], 
      [ "Terengganu", 11 ], 
      [ "Sabah", 12 ], 
      [ "Sarawak", 13 ],
      [ "Wilayah Persekutuan Kuala Lumpur", 14 ],
      [ "Wilayah Persekutuan Labuan", 15 ],
      [ "Wilayah Persekutuan Putrajaya", 16 ],
      [ "Luar Negara", 98 ],       
  ]
  
  NATIONALITY = [
       #  Displayed       stored in db
       [ "Warganegara",1],
       [ "Bukan Warganegara",2],
       [ "Penduduk Tetap", 3],
  ]
  
  STATUS = [
        #  Displayed       stored in db
        [ "Tetap",1 ],
        [ "Sementara",2 ],
        [ "Sambilan",3 ]
  ]
  
  APPOINTMENT = [
       #  Displayed       stored in db
       [ "Sandangan Tetap","1" ],
       [ "Sandangan Sementara","2" ],
       [ "Memangku Dengan Tujuan Naik Pangkat","3" ],
       [ "Memangku Bukan Dengan Tujuan Naik Pangkat","4" ],
       [ "Tanggung Kerja","5" ],
       [ "Sandangan Khas Untuk Penyandang","6" ],
       [ "Sandangan Sambilan","7" ],
       [ "Sandangan Khidmat Singkat","8" ]


  ]
  
  APPOINTED = [
       #  Displayed       stored in db
       [ "Kementerian Kesihatan Malaysia","kkm" ],
       [ "Suruhanjaya Perkhidmatan Awam","spa" ],
       [ "Jabatan Perkihidmatan Awam","jpa" ]
       
  ]
  
  HOS = [
       #  Displayed       stored in db
       [ "Suruhanjaya Perkhidmatan Awam","spa" ],
       [ "Kementerian Kesihatan Malaysia","kkm" ],
       [ "Jabatan Perkhidmatan Awam","jpa" ],
       [ "Jabatan Perpustakaan Negara","jpn" ]
       
  ]
  
  TOS = [
       #  Displayed       stored in db
       [ "Persekutuan","p" ],
       [ "Negeri","n" ]   
  ]
  
  PENSION = [
       #  Displayed       stored in db
       [ "Berpencen", "1"],
       [ "Pilihan KWSP", "2"],
       [ "Belum Memilih", "3"],
       [ "Tidak Layak Memilih","4"]

  ]
  
  UNIFORM = [
        #  Displayed       stored in db
        [ "Dibekalkan/Tidak dibekalkan", "1" ],
        [ "Tarikh Akhir di beri", "2" ],
        [ "Elaun Pakaian Panas/Pakaian Istiadat", "3" ]


  ]
  
  BANK = [
        #  Displayed       stored in db
        [ "Affin Bank Berhad","AFF" ],
        [ "Alliance Bank Berhad","ALB" ],
        [ "AmBank Berhad","AmB" ],
        [ "CIMB Bank Berhad","CIMB" ],
        [ "EON Bank Berhad","EON" ],
        [ "Hong Leong Bank Berhad","HLB" ],
        [ "Maybank","MBB" ],
        [ "Public Bank Berhad","PBB" ],
        [ "RHB Bank Berhad","RHB" ],
        [ "Bank Simpanan Nasional","BSN" ]
  ]
  
  BANKTYPE = [
        #  Displayed       stored in db
        [ "Simpanan","1" ],
        [ "Simpanan Bersama","2" ],
        [ "Semasa","3" ],
        [ "Simpanan Tetap","4" ],
  ]
  
  RACE = [
        #  Displayed       stored in db
        [ "Malay",1 ],
        [ "Chinese",2 ],
        [ "India",3 ],
        [ "Others",4 ],
  ]
  
  RELIGION = [
        #  Displayed       stored in db
        [ "Islam",1],
        [ "Buddha",2 ],
        [ "Hindu",3 ],
        [ "Others",4 ],
  ]
  
  GENDER = [
        #  Displayed       stored in db
        [ "Male","1"],
        [ "Female","2"]
  ]
  
  # 14/12/2011 - Shaliza added code if title no longer exists
  def title_details
     suid = titlecd_id.to_a
     exists = Title.find(:all, :select => "id").map(&:id)
     checker = suid & exists

     if titlecd_id == nil
       ""
     elsif checker == []
       "-"
     else
       title.name
     end
   end
 

#---------------Search--------------------------------------------------------------------------------
                        
  def self.search(search)
     if search
      @staff = Staff.find(:all, :conditions => ["icno LIKE ? or name ILIKE ?", "%#{search}%","%#{search}%"])
     else
      @staff = Staff.find(:all,  :include => [:title], :order => 'titles.id ASC')
     end
  end
 
end
 
                      
 