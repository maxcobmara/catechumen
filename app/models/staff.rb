class Staff < ActiveRecord::Base
  acts_as_reportable
  before_save  :titleize_name

  def titleize_name
    self.name = name.titleize
  end
  
  has_attached_file :photo#, :styles => {:thumb => "40x60"}
  #:styles => {:thumb => "100x100#" }
  
 # validates_attachment_presence :photo
   validates_attachment_size :photo, :less_than => 50.kilobytes
   validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
   
   
 #---------------Validations------------------------------------------------
     validates_numericality_of :icno#, :kwspcode
     validates_length_of       :icno, :is =>12
     validates_presence_of     :icno, :name, :coemail, :code
     validates_uniqueness_of   :icno, :fileno, :coemail, :code
     validates_format_of       :name, :with => /^[a-zA-Z'` ]+$/, :message => "contains illegal characters" #add unwanted chars between bracket
     validates_presence_of     :cobirthdt, :addr, :poskod_id, :staffgrade_id, :statecd, :country_cd
     #validates_length_of      :cooftelno, :is =>10
     #validates_length_of      :cooftelext, :is =>5
     validates_length_of       :addr, :within => 1..180,:too_long => "Address Too Long"
     validates_format_of       :coemail,
                               :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                               :message => "Email Not Valid"
 #-----------------------------------------------------------------------------------------------------------
  
  
#----------Link Foreign Key with other pages---------------------------------------------------

  has_many :documents,    :foreign_key => 'stafffiled_id' 
  has_many :books,        :foreign_key => 'receiver_id' 
  has_many :residence,    :foreign_key => 'staff_id'
  has_many :assets,       :foreign_key => 'staff_id'
  has_many :bulletins,    :foreign_key => 'postedby_id'
  has_many :sdiciplines,  :foreign_key => 'reportedby_id'
  has_many :strainings,   :foreign_key => 'staff_id'
  has_many :librarytransactions
  has_one  :position,     :foreign_key => 'staff_id'
  
  # has_many :topics, :foreign_key => 'creator_id' 
  #has_many :curriculums, :foreign_key => 'staff_id'
  #has_many :txsuppliess, :foreign_key => 'staff_id'
  #has_many :bulletins, :foreign_key => 'staff_id'  seriously?!  theres no staff_id in this table!  
  # you also repeated this in line 66!!!!!   Now see the corresponding in bulletin.rb
  #has_many :assetloss, :foreign_key => 'staff_id'
  #has_many :residence, :foreign_key => 'staff_id'
  #has_many :evactivities, :foreign_key => 'staff_id'
 
  
  #-----------------belongs_to other page-----------------------------------------------------
  
  belongs_to :title, :class_name => 'Title', :foreign_key => 'titlecd_id'
  belongs_to :level,  :class_name => 'Qualification', :foreign_key => 'level_id'
  belongs_to :staffgrade, :class_name => 'Staffgrade', :foreign_key => 'staffgrade_id'
  
  #-------------display data for different table-----------------------------------------------
 
  #Link to model user
  has_one :user
  
  #Link to Model TimetableEntry
   has_many :timetable,  :class_name => 'TimeTableEntry', :foreign_key => 'staff_id'
  
  #Link to model bulletin
  #has_many :bulletin, :class_name => 'bulletin', :foreign_key => 'postedby_id'  #posted by
  
  #Link to model Residence
  has_many :staff, :class_name => 'Residence', :foreign_key => 'staff_id'  
  has_many :admin, :class_name => 'Residence', :foreign_key => 'staffadmin_id'
  
  #Link to model Appraisal                                                      
  has_many :appraised, :class_name => 'Appraisal', :foreign_key => 'staff_id'
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
 # has_many :sdiciplines, :class_name => 'Sdicipline', :foreign_key => 'reportedby_id' # reported_by
  
  #Link to Model Travelclaim
  has_many :travelcode,    :class_name => 'Travelclaim',      :foreign_key => 'travelrequest_id'
  has_many :hod,           :class_name => 'Travelclaim',      :foreign_key => 'hod_id'
  
  #Link to Model Supplier
  has_many :issuesupply,      :class_name => 'usesupply',   :foreign_key => 'issuedby'
  has_many :receivesupply,    :class_name => 'usesupply',   :foreign_key => 'receivedby'
  
  #Link to Model Topic
  has_many :creator,    :class_name => 'Topic',    :foreign_key => 'creator_id'
  has_many :approver,   :class_name => 'Topic',    :foreign_key => 'approvedby_id'
  
  
  #link to model Examquestion
  has_many :approver,   :class_name => 'Examquestion',   :foreign_key => 'approver_id' #approver name
  has_many :creator,    :class_name => 'Examquestion',   :foreign_key => 'creator_id'  #creator name
  has_many :editor,     :class_name => 'Examquestion',   :foreign_key => 'editor_id'   #editor name
  
  
  #links to Model TravelRequest
  has_many :stafftravel,     :class_name => 'Travelrequest', :foreign_key => 'staff_id' #staff name
  has_many :replacements,       :class_name => 'Travelrequest', :foreign_key => 'replacement_id' #replacement name
  has_many :hod,                :class_name => 'Travelrequest', :foreign_key => 'hod_id' #hod
  
  #links to Model Attendances
  has_many :attendingstaffs,        :class_name => 'Attendance', :foreign_key => 'staff_id' #attendance staff name
  has_many :approvalsforstafflates, :class_name => 'Attendance', :foreign_key => 'approve_id' # approver name
  
  #links to Model Assetloss
   has_many :laststaff,        :class_name => 'Assetloss',   :foreign_key => 'lossstafflast_id' 
   has_many :hod,              :class_name => 'Assetloss',   :foreign_key => 'hod_id'
   has_many :enforce,          :class_name => 'Assetloss',   :foreign_key => 'newrule_id'
   has_many :officer,          :class_name => 'Assetloss',   :foreign_key => 'sio_id'
   
  #links to Model Course
  has_many :admin,        :class_name => 'Course', :foreign_key => 'staff_id'
  
  #links to Model leaveforstaffs
   has_many :leave_applications,  :class_name => 'Leaveforstaff', :foreign_key => 'staff_id'
   has_many :replacements,        :class_name => 'Leaveforstaff', :foreign_key => 'replacement_id'
  
  
  #links to Model Qualification
  has_many :qualification, :class_name => 'Qualification', :foreign_key => 'level_id'
  
  #links to Model Trainneeds
   has_many :staff_that_need_training, :class_name => 'Trainneed', :foreign_key => 'staff_id'
   has_many :training_managers, :class_name => 'Trainneed', :foreign_key => 'confirmedby_id'
   
   
#-------------Empty Field for Foreign Key Link------------------------
  has_many :courses  
#----------------------------------------------------------------------
   has_many :sdiciplines

#-------------------------------------------------------------------------
  has_many :attendances
#------------------------------------------------------------------------
    #approval of student leave
    has_many :leaveforstudents
#---------------------------------------------------------------------
     #has_many :travelclaims

    # def hod_with_name
    #   "#{formatted_mykad} #{name}"
    # end
#--------------------------------------------------------------------
  #has_many :travelrequests
#--------------------------------------------------------------------------
  
  



#----------------------------code for repeating field qualification------------------------------------------  
 
  has_many :qualifications, :dependent => :destroy
  
  def new_qualification_attributes=(qualification_attributes)
    qualification_attributes.each do |attributes|
      qualifications.build(attributes)
    end
  end
  
  after_update :save_qualifications
  
  def existing_qualification_attributes=(qualification_attributes)
    qualifications.reject(&:new_record?).each do |qualification|
      attributes = qualification_attributes[qualification.id.to_s]
      if attributes
        qualification.attributes = attributes
      else
        qualifications.delete(qualification)
      end
    end
  end
  
  def save_qualifications
    qualifications.each do |qualification|
      qualification.save(false)
    end
  end
#-----------------------------Code for Repeating Field Next OF Kin------------------------------------

  has_many :kins, :dependent => :destroy
  
  def new_kin_attributes=(kin_attributes)
     kin_attributes.each do |attributes|
       kins.build(attributes)
     end
   end

   after_update :save_kins

   def existing_kin_attributes=(kin_attributes)
     kins.reject(&:new_record?).each do |kin|
       attributes = kin_attributes[kin.id.to_s]
       if attributes
         kin.attributes = attributes
       else
         kins.delete(kin)
       end
     end
   end

   def save_kins
     kins.each do |kin|
       kin.save(false)
     end
   end
#------------------------------code for Repeating Field Loans----------------------------------------

   has_many :loans, :dependent => :destroy
   
   def new_loan_attributes=(loan_attributes)
       loan_attributes.each do |attributes|
         loans.build(attributes)
       end
     end

     after_update :save_loans

     def existing_loan_attributes=(loan_attributes)
       loans.reject(&:new_record?).each do |loan|
         attributes = loan_attributes[loan.id.to_s]
         if attributes
           loan.attributes = attributes
         else
           loans.delete(loan)
         end
       end
     end

     def save_loans
       loans.each do |loan|
         loan.save(false)
       end
     end
     
     
     
     
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
      "#{name}  (#{position.positionname})"
  end
  
  def staff_name_with_position
    "#{name}  (#{position_for_staff})"
  end
  
  def position_for_staff
    if position.blank?
      "-"
    else
      position.positionname
    end
  end
  
  def my_bank
    (Staff::BANK.find_all{|disp, value| value == bank }).map {|disp, value| disp}
  end
  
  
  def staff_positiontemp
    sid = staff.id
    spo = Position.find(:all, :select => "positionname", :conditions => {:staff_id => sid}).map(&:positionname)
    if spo = nil
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
      [ "O-",          "1" ],
      [ "O+",    "2" ],
      [ "A-", "3" ],
      [ "A+", "4" ],
      [ "B-", "5" ],
      [ "B+", "6" ],
      [ "AB-", "7" ]
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
  
  SCHEME = [
       #  Displayed       stored in db
       [ "Sokongan I","Sokongan I" ],
       [ "Sokongan II","Sokongan II" ],
       [ "Professional","Professional" ]
       
  ]
  
  GRADE = [
       #  Displayed       stored in db
       [ "U29","U29" ],
       [ "Jururawat","Jururawat" ],
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
       [ "Kementerian Kesihatan Malaysia","kkm" ]
       
  ]
  
  HOS = [
       #  Displayed       stored in db
       [ "Suruhanjaya Perkihidmatan Awam","spa" ]
       
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
 

#---------------Search--------------------------------------------------------------------------------
                        
  def self.search(search)
     if search
      @staff = Staff.find(:all, :conditions => ["icno LIKE ? or name ILIKE ?", "%#{search}%","%#{search}%"], :order => :icno)
     else
      @staff = Staff.find(:all,  :order => :icno)
     end
  end
 
end
 
                      
 