class Student < ActiveRecord::Base
  
  before_save  :titleize_name

  validates_presence_of     :icno, :name, :sstatus, :stelno, :ssponsor, :gender, :sbirthdt, :mrtlstatuscd, :intake,:course_id
  validates_numericality_of :icno, :stelno
  validates_length_of       :icno, :is =>12
  validates_uniqueness_of   :icno
  validates_format_of       :name, :with => /^[a-zA-Z'`\/\.\@\ ]+$/, :message => I18n.t('activerecord.errors.messages.illegal_char') #add allowed chars between bracket
  has_attached_file :photo,
                    :url => "/assets/students/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/students/:id/:style/:basename.:extension"
  
  
  has_and_belongs_to_many :klasses          #has_and_belongs_to_many :programmes
  belongs_to :course,         :class_name => 'Programme', :foreign_key => 'course_id'       #Link to Programme
  belongs_to :intakestudent,  :class_name => 'Intake',    :foreign_key => 'intake_id'       #Link to Model intake
  
  has_one   :login,              :dependent => :destroy                                      #Link to Model user
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
  
  def student_list
    "#{icno}"+" "+"#{name}"
    
  end  
  #@positions2.concat(positions_by_grade)
  def self.search3(search3)
     if search3
      @students3 = Student.find(:all, :conditions => ["icno LIKE ? ", "%#{search3}%"], :order => "name ASC")

     else
      @students3 = Student.find(:all,  :order => :icno)
     end
  end
  
  def self.search(search)
    if search
     @students = Student.find(:all, :conditions => ["icno LIKE ? or name ILIKE ? or matrixno ILIKE ? ", "%#{search}%","%#{search}%","%#{search}%"], :order => :icno)
     # @students = Student.find(:all, :condition => ["course_id LIKE ?", "%#{search}"])
    else
     @students = Student.find(:all)
    end
  end

  def self.search2(intake, programme)
    if intake!='0' && programme!='0'
        #@students = Student.find(:all, :conditions=> ['intake =? AND course_id=?',"%#{intake}%",programme]).sort_by{|t|t.intake} #group by program, then sort by intake (first) 
        @students = Student.find(:all, :conditions=> ['intake =? AND course_id=?',"%#{intake}%",programme]).sort_by{|t|t.course_id} #group by intake, then sort by programme (first)
    elsif intake!='0' && programme=='0'
        #@students = Student.find(:all, :conditions=> ['intake =?',"%#{intake}%"]).sort_by{|t|t.intake} #group by program, then sort by intake (first)
        @students = Student.find(:all, :conditions=> ['intake =?',"%#{intake}%"]).sort_by{|t|t.course_id} #group by intake, then sort by programme (first)
    elsif intake=='0' && programme!='0'
        #@students = Student.find(:all, :conditions=> ['course_id=?',programme]).sort_by{|t|t.intake} #group by program, then sort by intake (first)
        @students = Student.find(:all, :conditions=> ['course_id=?',programme]).sort_by{|t|t.course_id} #group by intake, then sort by programme (first)
    else
       #@students = Student.find(:all).sort_by{|t|t.intake} #group by program, then sort by intake (first)
       @students = Student.find(:all).sort_by{|t|t.intake}  #sort by intake, paginate & group by course for display
    end
  end
  
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
	
		  I18n.t('time.years').titleize+" #{@year}, <br> Semester #{@semester}"
  
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
  
  def intake_prog
    intake.to_date.to_s+"&"+course_id.to_s
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
   
   def self.get_intake(main_semester, main_year, programme)
     current_year = Date.today.year
     current_month = Date.today.month     #for testing - assign value as 8 (August)
     if current_month < 7 
       current_semester = 1
       current_sem_month = 1              #Sem January
     else 
       current_semester = 2 
       current_sem_month = 7              #Sem July
     end 
     if main_semester == 1 
       intake_month = current_sem_month 
       if main_year >1 
         intake_year = current_year-(main_year-1)
       else 
         intake_year = current_year 
       end 
     elsif main_semester == 2
       if current_sem_month == 1 
         intake_month = 7 
         intake_year = current_year-main_year 
       else 
         intake_month = 1 
         intake_year = current_year-(main_year-1) 
       end 
     end 
     return Date.new(intake_year, intake_month,1) 
   end 
   
   def self.get_student_by_intake_gender_race(main_semester, main_year, gender, programme, race)
     intake_start = Student.get_intake(main_semester, main_year, programme)
     intake_end = intake_start.end_of_month
     return Student.find(:all, :conditions => ['intake >=? AND intake<=? AND course_id=? AND race2=? AND gender=?',intake_start, intake_end, programme, race, gender])
   end
   
   def self.get_student_by_intake_gender(main_semester, main_year, gender, programme)
     intake_start = Student.get_intake(main_semester, main_year, programme)
     intake_end = intake_start.end_of_month
     return Student.find(:all, :conditions => ['intake >=? AND intake<=? AND course_id=? AND gender=? AND race2 IS NOT NULL',intake_start, intake_end, programme, gender])
   end
   
   def self.get_student_by_6intake(programme) #return all students for these 6 intake - valid & invalid
     intake_start1 = Student.get_intake(1, 1, programme)
     intake_end1 = intake_start1.end_of_month
     intake_start2 = Student.get_intake(2, 1, programme)
     intake_end2 = intake_start2.end_of_month
     intake_start3 = Student.get_intake(1, 2, programme)
     intake_end3 = intake_start3.end_of_month
     intake_start4 = Student.get_intake(2, 2, programme)
     intake_end4 = intake_start4.end_of_month
     intake_start5 = Student.get_intake(1, 3, programme)
     intake_end5 = intake_start5.end_of_month
     intake_start6 = Student.get_intake(2, 3, programme)
     intake_end6 = intake_start6.end_of_month
     return Student.find(:all, :conditions => ['((intake >=? AND intake<=?) OR (intake >=? AND intake<=?) OR (intake >=? AND intake<=?) OR (intake >=? AND intake<=?) OR (intake >=? AND intake<=?) OR (intake >=? AND intake<=?)) AND course_id=?',intake_start1, intake_end1,intake_start2, intake_end2, intake_start3, intake_end3, intake_start4, intake_end4,intake_start5, intake_end5,intake_start6, intake_end6,programme])
   end
   
# ------------------------------code for repeating field qualification---------------------------------------------------
 has_many :qualifications, :dependent => :destroy
 accepts_nested_attributes_for :qualifications, :reject_if => lambda { |a| a[:level_id].blank? }
  
 has_many :kins, :dependent => :destroy
 accepts_nested_attributes_for :kins, :allow_destroy => true, :reject_if => lambda { |a| a[:kintype_id].blank? }
 validates_associated :kins
 
 has_many :spmresults, :dependent => :destroy
 accepts_nested_attributes_for :spmresults, :reject_if => lambda { |a| a[:spm_subject].blank? }
 
 
 def display_race
   "#{(Student::RACE.find_all{|disp, value| value == race2.to_i}).map {|disp, value| disp}}"
 end
 
 def display_intake
   "#{intake.to_date.strftime("%b %Y") }"
 end
 
 def display_regdate
   "#{regdate.to_date.strftime("%d-%b-%Y")}"
 end
 def display_gender
  "#{(Student::GENDER.find_all{|disp, value| value == gender.to_s}).map {|disp, value| disp}}"
 end   
 
 def display_enddate
   "#{end_training.to_date.strftime("%d-%b-%Y")}"
 end
 
 def display_bloodtype
   "#{(Student::BLOOD_TYPE.find_all{|disp, value| value == bloodtype.to_s}).map {|disp, value| disp}}"
 end
 
 def display_address
   address.to_s
 end
 #export excel section ---
 
 def self.header_excel
  ["Mykad No", "Student Name", "Matrix No", "Programme", "Intake", "Registration Date","End Training Date","Remarks", "Offer Letter","Race","Status","Gender","Tel No.", "Email","Physical","Allergy","Disease","Blood Type", "Medication", "Remarks"]
  #, "Address" - to add in later
 end
 
 def self.column_excel
   #[{:exampaper=>[:examtypename,{:subject => :subject_list}]},:gradeA, :gradeAminus, :gradeBplus,:gradeB, :gradeBminus, :gradeCplus,:gradeC, :gradeCminus,:gradeDplus,:gradeD,:gradeE ]

   [:formatted_mykad, :name, :matrixno, {:course => :programme_list}, :display_intake, :display_regdate,:display_enddate,:course_remarks, :offer_letter_serial,:display_race,:sstatus,:display_gender,:stelno,:semail, :physical,:allergy,:disease,:display_bloodtype,:medication, :remarks]  #  , :display_address --> to add in later
 end
  
  
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
        [ "Orang Asli", 4],
        [ "Bajau", 5],
        [ "Murut",6],
        [ "Brunei",7],
        [ "Bisaya",8],
        [ "Kadazan",9],
        [ "Suluk",10],
        [ "Kedayan",11],
        [ "Iban",12],
        [ "Kadazan Dusun",13],
        [ "Sungal",14],
        [ "Siam",15],
        [ "Melanau",16],
        [ "Bugis",17],
        [ "Bidayuh",18],
        [ "Momogun Rungus",19],
        [ "Dusun",20],
        [ "Lain-Lain",21]
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
