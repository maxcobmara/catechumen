class Staff < ActiveRecord::Base
  #acts_as_reportable
  before_save  :titleize_name

  def titleize_name
    self.name = name.titleize
  end
  
  has_attached_file :photo,
                    :url => "/assets/staffs/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/staffs/:id/:style/:basename.:extension"#, :styles => {:thumb => "40x60"}
  #:styles => {:thumb => "100x100#" }
  
 # validates_attachment_presence :photo
  validates_attachment_size         :photo, :less_than => 500.kilobytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
 #---------------Validations------------------------------------------------
  validates_numericality_of :icno#, :kwspcode
  validates_length_of       :icno, :is =>12
  validates_presence_of     :icno, :name, :coemail, :code
  validates_uniqueness_of   :icno, :fileno, :coemail, :code
  validates_format_of       :name, :with => /^[a-zA-Z'` ]+$/, :message => "contains illegal characters" #add unwanted chars between bracket
  validates_presence_of     :cobirthdt, :addr, :poskod_id, :staffgrade_id, :statecd, :country_cd, :fileno
  #validates_length_of      :cooftelno, :is =>10
  #validates_length_of      :cooftelext, :is =>5
  validates_length_of       :addr, :within => 1..180,:too_long => "Address Too Long"
  validates_format_of       :coemail,
                               :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                               :message => "Email Not Valid"
 #-----------------------------------------------------------------------------------------------------------
  
  
#----------Link Foreign Key with other pages---------------------------------------------------

  has_many :documents,    :class_name => 'Documents', :foreign_key => 'stafffiled_id' 
  has_many :cc1s,         :class_name => 'Documents', :foreign_key => 'cc1staff_id' 
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
  has_many :users
  has_many :timetables
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
 
  #Link to model bulletin
  #has_many :bulletin, :class_name => 'bulletin', :foreign_key => 'postedby_id'  #posted by
  
  #Trainingrequest
  has_many :applicants, :class_name => 'Trainingrequest', :foreign_key => 'staff_id'
  has_many :approvers, :class_name => 'Trainingrequest', :foreign_key => 'approvedby_id'
  #has_many :trainingrequests
  
  #Link to model Staff Appraisal                                                      
  has_many :appraisals,     :class_name => 'StaffAppraisal', :foreign_key => 'staff_id', :dependent => :destroy
  has_many :eval1_officers, :class_name => 'StaffAppraisal', :foreign_key => 'eval1_by'
  has_many :eval2_officers, :class_name => 'StaffAppraisal', :foreign_key => 'eval2_by'
  
  
  #Link to model Asset Defect
  has_many :reporters, :class_name => 'AssetDefect', :foreign_key => 'reported_by'
  
  #Link to model Asset Disposal
  has_many :processors, :class_name => 'AssetDisposal', :foreign_key => 'checked_by'
  has_many :verifiers,  :class_name => 'AssetDisposal', :foreign_key => 'verified_by'
  has_many :revaluers,  :class_name => 'AssetDisposal', :foreign_key => 'revalued_by'
    
  #Link to model AssetTrack
  has_many :asset_loans
  has_many :owners, :class_name => 'AssetLoan', :foreign_key => 'loaned_by'
  has_many :hods,   :class_name => 'AssetLoan', :foreign_key => 'hod'
  #has_many :staffinassettrack, :class_name => 'assettrack', :foreign_key => 'staff_id'
  #has_many :isby,              :class_name => 'assettrack', :foreign_key => 'issuedby'
  #has_many :assettrackreturn,  :class_name => 'assettrack', :foreign_key => 'returnedto'  
  
  #
  has_and_belongs_to_many :messages
  has_many :from, :class_name => 'Staff', :foreign_key => 'from_id'
  
  #links to Model Cofile
  has_many :owners,    :class_name => 'Cofiles', :foreign_key => 'owner_id'
  has_many :borrowers, :class_name => 'Cofiles', :foreign_key => 'staffloan_id'
  
  #Link to Model travel_claim
  has_many :travel_claims, :dependent => :destroy
  has_many :approvers,           :class_name => 'TravelClaim',      :foreign_key => 'approved_by'
  
  #Link to Model Supplier
  has_many :issuesupply,      :class_name => 'usesupply',   :foreign_key => 'issuedby'
  has_many :receivesupply,    :class_name => 'usesupply',   :foreign_key => 'receivedby'
  
  #Link to Model Topic
  has_many :creator,    :class_name => 'Topic',    :foreign_key => 'creator_id'
  has_many :approver,   :class_name => 'Topic',    :foreign_key => 'approvedby_id'
  
  #Link to Model Training Report
  has_many :creator,  :class_name => 'Trainingreport',  :foreign_key => 'staff_id'
  has_many :tpa,      :class_name => 'Trainingreport',  :foreign_key => 'tpa_id'
  
  #link to model Examquestion
  has_many :approver,   :class_name => 'Examquestion',   :foreign_key => 'approver_id' #approver name
  has_many :creator,    :class_name => 'Examquestion',   :foreign_key => 'creator_id'  #creator name
  has_many :editor,     :class_name => 'Examquestion',   :foreign_key => 'editor_id'   #editor name
  
  #link to model Exams
  has_many :creators,          :class_name => 'Exam',   :foreign_key => 'created_by'
  
  
  
  
  #links to Model TravelRequest
  has_many :staffs,             :class_name => 'TravelRequest', :foreign_key => 'staff_id', :dependent => :destroy #staff name
  has_many :replacements,       :class_name => 'TravelRequest', :foreign_key => 'replaced_by' #replacement name
  has_many :headofdepts,        :class_name => 'TravelRequest', :foreign_key => 'hod_id' #hod
  
  #links to Model Attendances
  has_many :attendingstaffs,    :class_name => 'StaffAttendance', :foreign_key => 'thumb_id', :primary_key => 'thumb_id'#, :dependent => :destroy #attendance staff name
  has_many :approvers,          :class_name => 'StaffAttendance', :foreign_key => 'approved_by' # approver name
  
  #links to Model Assetloss
   has_many :handlers,      :class_name => 'AssetLoss',   :foreign_key => 'last_handled_by' 
   has_many :enforcers,     :class_name => 'AssetLoss',   :foreign_key => 'prev_action_enforced_by' 
   has_many :investigators, :class_name => 'AssetLoss',   :foreign_key => 'investigated_by' 
   has_many :sec_officers,  :class_name => 'AssetLoss',   :foreign_key => 'security_officer_id'
   has_many :hods,          :class_name => 'AssetLoss',   :foreign_key => 'security_officer_id'


   
  #links to Model Course
  has_many :admin,        :class_name => 'Course', :foreign_key => 'staff_id'
  
  #links to Model leaveforstaffs
   has_many :leave_applications, :class_name => 'Leaveforstaff', :foreign_key => 'staff_id', :dependent => :destroy
   has_many :replacements,       :class_name => 'Leaveforstaff', :foreign_key => 'replacement_id', :dependent => :nullify
   has_many :seconders,          :class_name => 'Leaveforstaff', :foreign_key => 'approval1_id', :dependent => :nullify
   has_many :approvers,          :class_name => 'Leaveforstaff', :foreign_key => 'approval2_id', :dependent => :nullify
  
  
  #links to Model Qualification
  #has_many :qualification, :class_name => 'Qualification', :foreign_key => 'level_id'
  
  #links to Model Trainneeds
   has_many :staff_that_need_training, :class_name => 'Trainneed', :foreign_key => 'staff_id'
   has_many :training_managers, :class_name => 'Trainneed', :foreign_key => 'confirmedby_id'
   
   
#-------------Empty Field for Foreign Key Link------------------------
  has_many :courses
  has_many :sdiciplines
  has_many :attendances
  has_many :leaveforstudents  #approval of student leave
#---------------------------------------------------------------------
     

    # def hod_with_name
    #   "#{formatted_mykad} #{name}"
    # end
#--------------------------------------------------------------------
  #has_many :travelrequests
#--------------------------------------------------------------------------
  
  has_many :student_counseling_sessions, :as => :created_by,  :foreign_key => 'created_by' 
  



#----------------------------code for repeating fields------------------------------------------  
 
  has_many :qualifications, :dependent => :destroy
  accepts_nested_attributes_for :qualifications, :reject_if => lambda { |a| a[:level_id].blank? }
  
  has_many :loans, :dependent => :destroy
  accepts_nested_attributes_for :loans, :reject_if => lambda { |a| a[:ltype].blank? }

  has_many :kins, :dependent => :destroy
  accepts_nested_attributes_for :kins, :reject_if => lambda { |a| a[:kintype_id].blank? }
  
  has_many :bankaccounts, :dependent => :destroy
  accepts_nested_attributes_for :bankaccounts, :reject_if => lambda { |a| a[:account_no].blank? }
  
 
     
     
     
#--------------------Declerations----------------------------------------------------
  def age
    Date.today.year - cobirthdt.year
  end
 
  def formatted_mykad
    "#{icno[0,6]}-#{icno[6,2]}-#{icno[-4,4]}"
  end
  
  def staff_name_then_mykad
    "#{name}  (#{formatted_mykad})"
  end
  
  def mykad_with_staff_name
    "#{formatted_mykad}  #{name}"
  end

  def position_with_name   #this currenlt works with staff leave
      "#{name}  (#{position.name})"
  end
  
  def staff_name_with_position
    "#{name}  (#{position_for_staff})"
  end
  
  def position_for_staff
    if position.blank?
      "-"
    else
      position.name
    end
  end
  
  
  def my_bank
    sid = id
    b = Bankaccount.find(:all, :select => "bank_id", :conditions => {:staff_id => sid}).map(&:bank_id)
    if b == nil
      "No Account Registered"
    else
      id = b[0]
      Bank.find(:all, :select => "long_name", :conditions => {:id => id}).map(&:long_name).to_s
    end
  end

  
  def render_reports_to
    if position.blank? 
      ""
    elsif position.parent.blank?
      "-"
    elsif position.parent.staff.blank?
      "#{position.parent.name}"
    else 
      "#{position.parent.name} - #{position.parent.staff.name}"
    end
  end
  
  
  def staff_positiontemp
    sid = staff.id
    spo = Position.find(:all, :select => "name", :conditions => {:staff_id => sid}).map(&:name)
    if spo == nil
      "NA"
    else 
      @staff.position.name
    end 
  end
  
  def staff_position
    sid = staff.id
    Position.find(:all, :select => "name", :conditions => {:staff_id => sid}).map(&:name)
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
      [ "O-",          "1" ],
      [ "O+",    "2" ],
      [ "A-", "3" ],
      [ "A+", "4" ],
      [ "B-", "5" ],
      [ "B+", "6" ],
      [ "AB-", "7" ],
      [ "AB+", "8" ]
      
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
       [ "Jabatan Perkhidmatan Awam","jpa" ]
       
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
 

#---------------Search--------------------------------------------------------------------------------
                        
  def self.search(search)
     if search
      @staff = Staff.find(:all, :conditions => ["icno LIKE ? or name ILIKE ?", "%#{search}%","%#{search}%"], :order => :icno)
     else
      @staff = Staff.find(:all,  :order => :icno)
     end
  end
 
end
 
                      
 