class AnalysisGrade < ActiveRecord::Base
  
  before_save :varmyass
  
  validates_presence_of     :exam_paper_name, :message => "Can't Be Blank"
  
  #links to Model programmes
   belongs_to :course_name,    :class_name => 'Programme', :foreign_key => 'course_id'
   
   belongs_to :classroom, :class_name => 'Klass', :foreign_key => 'class_id'
   #links to Model staff
   belongs_to :examiner, :class_name => 'Staff', :foreign_key => 'staff_id'
   
   belongs_to :examname, :class_name => 'Exammaker', :foreign_key => 'exam_paper_name'
   
   has_many :student_marks, :dependent => :destroy
   accepts_nested_attributes_for :student_marks, :reject_if => lambda { |a| a[:m_1].blank? }
   
    def bil
        v=1
     end
     
     def calculatefullmark
     columns_names = ['fm_1','fm_2','fm_3','fm_4', 'fm_5', 'fm_6', 'fm_7'] # array of name of the columns
     obj = analysis_grade.find(:id) # find the object with id

     # loop and get column values that are set

     values = columns_names.inject([]) do |arr,column_name|
       arr << obj.column_name if params[column_name].eql?"true" # collect the values if the column set
       arr
     end

     #get average
     if values.blank?
       0
     else
       avg =  values.reduce(:+)/values.size
     end
     
   end 
     
     def varmyass
       self.student_id	= totalfullmark
     end

     def totalfullmark
       fm_1 + fm_2 + fm_3 + fm_4 + fm_5 + fm_6 + fm_7 + fm_8 + fm_9 + fm_10 +
       fm_11 + fm_12 + fm_13 + fm_14 + fm_15 + fm_16 + fm_17 + fm_18 + fm_19 +
       fm_20 + fm_21 + fm_22 + fm_23 + fm_24 + fm_25 + fm_26 + fm_27 + fm_28 +
       fm_29 + fm_30 + fm_31 + fm_32 + fm_33 + fm_34 + fm_35 + fm_36 + fm_37 + fm_38 +
       fm_39 + fm_40 + fm_41 + fm_42 + fm_43 + fm_44 + fm_45 + fm_46 + fm_47 + fm_48 +
       fm_49 + fm_50 
     end
end
