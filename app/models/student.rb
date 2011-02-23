class Student < ActiveRecord::Base
  
    #------------------Validations--------------------------------------------------------------------------------------

    validates_presence_of     :icno, :name, :matrixno, :sstatus, :stelno, :ssponsor, :gender, :semail, :sbirthdt, 
                              :mrtlstatuscd
    validates_numericality_of :icno, :stelno
    validates_length_of       :icno, :is =>12
    validates_uniqueness_of   :icno, :matrixno


  #----------------------Search------------------------------------------------------------------------------------------
  
  
  #----Link to klass---Self Join--------------------------------------------------------------------------------------
  has_and_belongs_to_many :klasses
  #has_and_belongs_to_many :programmes
  
  
  #--------belongs with other page-------------------------------------------------------------------------------------
  
  #Link to Programme
  belongs_to :course, :class_name => 'Programme', :foreign_key => 'course_id'
  
  #Link to Model intake
  belongs_to :intakestudent, :class_name => 'Intake', :foreign_key => 'intake_id'
  
  
  #------------Link with Other Page-------------------------------------------------------------------------------------
  #Link to Model user
  has_one :user
  
  #Link to Model Grade
  has_many :studentgrade,  :class_name => 'Grade', :foreign_key => 'student_id'
  
  #Link to Model Sdicipline
  has_many :student,  :class_name => 'Sdicipline', :foreign_key => 'student_id'
  
  #Link to Model CourseEvaluation
  has_many :studentevaluate,  :class_name => 'Courseevaluation', :foreign_key => 'student_id'
  
  #Link to LeaveStudent
  has_many :leaveforstudents
  
  #Link to Model residence
  has_many :student, :class_name => 'Residence', :foreign_key => 'student_id'
  
  #Link to Counselling
  has_many :counsellings
  
  #has_many :sdiciplines, :foreign_key => 'student_id'
 
 #Link to LibraryTransactions
  has_many :librarytransactions
  
  # has_many :std, :class_name => 'Sdicipline', :foreign_key => 'student_id'
  
  

 
  def self.search(search)
    if search
      @students = Student.find(:all, :conditions => ["icno LIKE ? or name ILIKE ? or matrixno ILIKE ?", "%#{search}%","%#{search}%","%#{search}%"], :order => :icno)
    else
     @students = Student.find(:all)
    end
  end
  
  def self.find_main
      Programme.find(:all, :condition => ['programme_id IS NULL'])
  end
  

# ------------------------------code for repeating field qualification---------------------------------------------------
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
 
# ----------------------------Code for Repeating Field Next OF Kin------------------------------------------------------------
 

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
  
#----------------------Declarations-------------------------------------------------------------------------------------------------
  
  def formatted_mykad
    "#{icno[0,6]}-#{icno[6,2]}-#{icno[-4,4]}"
  end
  
  def formatted_mykad_and_student_name
    " #{formatted_mykad} #{name}" 
  end
  
  def bil
    v=1
   end
   
#----------------Coded List-----------------------------------------------------------------------------------------------------------
  
STATUS = [
           #  Displayed       stored in db
           [ "Current","Current" ],
           [ "Graduated","Graduated" ],
           [ "Repeat", "Repeat" ],
           [ "On Leave", "On Leave" ]
           
] 
  
SPONSOR = [
         #  Displayed       stored in db
         [ "Kementerian Kesihatan Malaysia","KKM" ],
         [ "Suruhanjaya Perkhidmatan Awam","SPA" ],
         [ "Sendiri", "FaMa" ]
] 
  
GENDER = [
        #  Displayed       stored in db
        [ "Male","1" ],
        [ "Female","2" ]
]
  
SESSION = [
        #  Displayed       stored in db
        [ "January","1" ],
        [ "July","2" ]
  ]
  
MARITAL_STATUS = [
        #  Displayed       stored in db
        [ "Tidak Pernah Berkahwin","1" ],
        [ "Berkahwin","2" ],
        [ "Balu", "3" ],
        [ "Duda", "4" ],
        [ "Bercerai", "5" ],
        [ "Berpisah", "6" ],
        [ "Tiada Maklumat", "9" ]
]
      
CLASS= [
          #  Displayed       stored in db
          [ "1","1" ],
          [ "2","2" ],
          [ "3", "3" ],
          [ "4", "4" ],
          [ "5", "5" ],
          [ "6", "6" ]
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
    

    
   
end
