class Student < ActiveRecord::Base
  
  before_save  :titleize_name

  validates_presence_of     :icno, :name, :sstatus, :stelno, :ssponsor, :gender, :sbirthdt, :mrtlstatuscd, :intake,:course_id
  validates_numericality_of :icno, :stelno
  validates_length_of       :icno, :is =>12
  validates_uniqueness_of   :icno
  
  has_attached_file :photo,
                    :url => "/assets/students/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/students/:id/:style/:basename.:extension"
  
  
  has_and_belongs_to_many :klasses          #has_and_belongs_to_many :programmes
  belongs_to :course,         :class_name => 'Programme', :foreign_key => 'course_id'       #Link to Programme
  belongs_to :intakestudent,  :class_name => 'Intake',    :foreign_key => 'intake_id'       #Link to Model intake
  
  has_one   :user,              :dependent => :destroy                                      #Link to Model user
  has_many  :leaveforstudents,  :dependent => :destroy                                      #Link to LeaveStudent
  has_many  :student_counseling_sessions                                                    #Link to Counselling
  
  has_many  :studentgrade,    :class_name => 'Grade',     :foreign_key => 'student_id'      #Link to Model Grade
  has_many  :student,         :class_name => 'Sdicipline',:foreign_key => 'student_id'      #Link to Model Sdicipline
  has_many  :studentevaluate, :class_name => 'Courseevaluation', :foreign_key => 'student_id'#Link to Model CourseEvaluation
  has_many  :student,         :class_name => 'Residence', :foreign_key => 'student_id'      #Link to Model residence
  has_many  :tenants
  
  has_many  :librarytransactions                                                            #Link to LibraryTransactions
  #has_many :studentattendances
  has_many :student_attendances
  has_many :timetables, :through => :studentattendances
  
  has_many :exammarks                                                                       #11Apr2013-Link to Model Exammark
  
  #has_many :sdiciplines, :foreign_key => 'student_id'
  #has_many :std, :class_name => 'Sdicipline', :foreign_key => 'student_id'
  
  def self.search(search)
    if search
     @students = Student.find(:all, :conditions => ["icno LIKE ? or name ILIKE ? or matrixno ILIKE ? ", "%#{search}%","%#{search}%","%#{search}%"], :order => :icno)
     # @students = Student.find(:all, :condition => ["course_id LIKE ?", "%#{search}"])
    else
     @students = Student.find(:all)
    end
  end

  def self.search2(search2)
    if search2
     @students = Student.find(:all, :conditions=> ['intake =?',"%#{search2}%"])
    else
     @students = Student.find(:all)
    end
  end
  
  named_scope :all 
  named_scope :carakerja,     :conditions =>  ["course_id=?", 1]
  named_scope :fisioterapi,   :conditions =>  ["course_id=?", 2]
  named_scope :kejururawatan, :conditions =>  ["course_id=?", 3]
  named_scope :peg_perubatan, :conditions =>  ["course_id=?",4]
  named_scope :radiografi, :conditions =>  ["course_id=?",5]
  named_scope :perioperating, :conditions =>  ["course_id=?",6]
  named_scope :orthopedik, :conditions =>  ["course_id=?",7]
  named_scope :onkologi, :conditions =>  ["course_id=?",8]
  named_scope :koronari, :conditions =>  ["course_id=?",9]
  named_scope :perawatanrapi, :conditions =>  ["course_id=?",10]
  named_scope :perawatanrenal, :conditions =>  ["course_id=?",11]
  named_scope :psikiatri, :conditions =>  ["course_id=?",12]
  named_scope :neonate, :conditions =>  ["course_id=?",67]
  named_scope :kebidanan, :conditions =>  ["course_id=?",13]
  named_scope :imejan, :conditions =>  ["course_id=?",14]
  
  FILTERS = [
    {:scope => "all",       :label => "All"},
    {:scope => "carakerja",    :label => "Diploma Jurupulih Perubatan Cara Kerja"},
    {:scope => "fisioterapi",     :label => "Diploma Jurupulih Perubatan Anggota (Fisioterapi)"},
    {:scope => "kejururawatan", :label => "Diloma Kejururawatan"},
    {:scope => "peg_perubatan", :label => "Diploma Pen Pegawai Perubatan"},
    {:scope => "radiografi",  :label => "Diploma Radiografi"},
    {:scope => "perioperating",  :label => "Posbasik Perioperating"},
    {:scope => "orthopedik",:label => "Posbasik Orthopedik"},
    {:scope => "onkologi",      :label => "Posbasik Onkologi"},
    {:scope => "koronari",    :label => "Posbasik Perubatan Koronari"},
    {:scope => "perawatanrapi", :label => "Posbasik Perawatan Rapi"},
    {:scope => "perawatanrenal", :label => "Posbasik Perawatan Renal"},
    {:scope => "psikiatri", :label =>"Posbasik Perawatan Psikiatri"},
    {:scope => "neonate", :label => "Posbasik Neonate"},
    {:scope => "kebidanan", :label =>"Diploma lanjutan Kebidanan"},
    {:scope => "imejan", :label =>"Diploma Lanjutan Pengimejan Perubatan Payudara"}
    ]
  
  def self.find_main
      Programme.find(:all, :condition => ['programme_id IS NULL'])
  end
  
  def self.year_and_sem(intake)
      current_month = Date.today.strftime("%m")
		  current_year = Date.today.strftime("%Y")
		  intake_month = intake.strftime("%m")
		  intake_year = intake.strftime("%Y")
		  diff_year = current_year.to_i-intake_year.to_i
		  start_year = 1
		  start_sem = 1
		
		  if intake_month.to_i < 7 
			  if current_month.to_i < 7 
				  @year = start_year + diff_year 
				  @semester = start_sem 
			  elsif current_month.to_i > 6 
				  @year = start_year + diff_year 
				  @semester = 2 
			  end 
		  elsif intake_month.to_i > 6 
			  if current_month.to_i < 7 
				  @year = diff_year 
				  @semester = 2 							
			  elsif current_month.to_i > 6 
			    @year = start_year + diff_year 
				  @semester = 1 
			  end
		  end 
	
		  "Year #{@year}, <br> Semester #{@semester}"
  
  end
  
#----------------------Declarations---------------------------------------------------------------------------------
  def titleize_name
    self.name = name.titleize
  end
  
  def age
    Date.today.year - sbirthdt.year
  end
  
  def intake_acryn
      intake.to_date.strftime("%b %Y") 
  end 
  
  def intake_acryn_prog
      intake.to_date.strftime("%b %Y")+" | #{course.course_type} - #{course.name}"
  end
  
  #group by intake
 # def isorter
 #   suid = intake_id
 #   Intake.find(:all, :select => "name", :conditions => {:id => suid}).map(&:name)
 # end
  
  def formatted_mykad
    "#{icno[0,6]}-#{icno[6,2]}-#{icno[-4,4]}"
  end
  
  def formatted_mykad_and_student_name
    " #{formatted_mykad} #{name}" 
  end
  
  def matrix_name
    " #{matrixno} #{name}" 
  end
  
  def bil
    v=1
  end
  
  def student_name_with_programme
    "#{name} - #{programme_for_student}"
  end
  
  def programme_for_student
    if course.blank?
      "N/A"
    else
      "[#{course.course_type} - #{course.name}]"
    end
  end
  def programme_for_student2
    if course.blank?
      "N/A"
    else
      "#{course.course_type} - #{course.name}"
    end
  end
  
  def list_programme
    suid = course_id 
    Programme.find(:all, :select => "name", :conditions => {:id => suid}).map(&:name)
  end
   
   def bil
      v=1
   end
   
   def self.available_students2(subject)
       Student.find(:all, :joins=>:klasses, :conditions=> ['subject_id=?',subject])
   end
   
   
   
# ------------------------------code for repeating field qualification---------------------------------------------------
 has_many :qualifications, :dependent => :destroy
 accepts_nested_attributes_for :qualifications, :reject_if => lambda { |a| a[:level_id].blank? }
 
 has_many :kins, :dependent => :destroy
 accepts_nested_attributes_for :kins, :reject_if => lambda { |a| a[:kintype_id].blank? }
 
 has_many :spmresults, :dependent => :destroy
 accepts_nested_attributes_for :spmresults, :reject_if => lambda { |a| a[:spm_subject].blank? }
 
  
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
         [ "Swasta","swasta" ],
         [ "Sendiri", "FaMa" ]
] 
  
GENDER = [
        #  Displayed       stored in db
        [ "Male","1" ],
        [ "Female","2" ]
]

#Pls note 'race2' field is for race whereas 'race' field is for etnic
RACE = [
        #  Displayed       stored in db
        [ "Melayu", 1 ],
        [ "Cina", 2],
        [ "India", 3],
        [ "Bumiputera Sabah & Sarawak", 4],
        [ "Lain-Lain", 5]
]
  
SESSION = [
        #  Displayed       stored in db
        [ "January","1" ],
        [ "July","2" ]
  ]
  
MARITAL_STATUS = [
        #  Displayed       stored in db
        [ "Bujang","1" ],
        [ "Berkahwin","2" ],
        [ "Lain Lain", "3"]
        #[ "Balu", "3" ],[ "Duda", "4" ],[ "Bercerai", "5" ],[ "Berpisah", "6" ],[ "Tiada Maklumat", "9" ]
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
             [ "AB-", "7" ],
             [ "AB+", "8" ]
    ]
    

    
   
end
