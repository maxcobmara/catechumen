class AverageCourse < ActiveRecord::Base
  
  belongs_to :evaluated_lecturer, :class_name => 'Staff',     :foreign_key => 'lecturer_id'   #8March2013
  belongs_to :principal,          :class_name => 'Staff',     :foreign_key => 'principal_id'
  belongs_to :subjectavg,         :class_name => 'Subject',   :foreign_key => 'subject_id'
  belongs_to :course,             :class_name => 'Programme', :foreign_key => 'programme_id'	#8March2013

  attr_accessor :lecturer_subject	  #8March2013

  before_save :save_my_vars

  #8March2013-assign values for 'subject_id' & 'lecturer_id' from selected 'lecturer_subject'
  def save_my_vars
  	if subject_id==nil && lecturer_id == nil   
  		self.subject_id = EvaluateCourse.find(lecturer_subject).subject_id
  	  self.lecturer_id = EvaluateCourse.find(lecturer_subject).staff_id
    end
  end
  #8March2013assign values for 'subject_id' & 'lecturer_id' from selected 'lecturer_subject'

  #8March2013-select AVAILABLE lecturers+subjects combination
  def self.get_lecturers_subjects  
  	@lecturers_subjects_list=[] 
  	EvaluateCourse.all.group_by { |t| t.staff_id }.each do |staff, evaluations| 
  		evaluations.group_by { |t| t.subject_id }.each do |subject, evaluation|
  			evaluation.each_with_index do |evaluate,index|
  			  @exist_subject_staff = AverageCourse.find(:all, :conditions=>['subject_id=? AND lecturer_id=?',subject,staff]).count
  				@lecturers_subjects_list << evaluate if index==0 && @exist_subject_staff==0
  			end 
  		end 
  	end
  	return @lecturers_subjects_list
  end
  #8March2013-select AVAILABLE lecturers+subjects combination

  #20Feb2013-
  def self.find_evaluations(staff,subject)
    EvaluateCourse.find(:all, :conditions => ['staff_id=? AND subject_id=?', staff, subject])
  end

  def self.find_average(staff,subject,itemno)
    @evaluation_results = AverageCourse.find_evaluations(staff,subject)    #EvaluateLecturer.find(:all, :conditions => ['staff_id=? AND subject_id=?', staff, subject])
    @result_ev=[]
    @evaluation_results.each do |evaluation_result|
     	 if itemno==1
     	   @result_ev << evaluation_result.ev_obj 
     	 elsif itemno==2
     	   @result_ev << evaluation_result.ev_knowledge 
     	 elsif itemno==3
     	   @result_ev << evaluation_result.ev_deliver 
     	 elsif itemno==4
     	   @result_ev << evaluation_result.ev_content 
     	 elsif itemno==5
     	   @result_ev << evaluation_result.ev_tool 
     	 elsif itemno==6
         @result_ev << evaluation_result.ev_topic 
       elsif itemno==7   
     	   @result_ev << evaluation_result.ev_work 
     	 elsif itemno==8 
     	   @result_ev << evaluation_result.ev_note 
     	 end 	 
    end 
    aa=@result_ev.inject{|sum, element| sum + element}.to_f/@result_ev.size 
    return DecNum(aa.to_s).round  #8March2013
  end
  #20Feb2013-


  CATEGORY = [
      #  Displayed       stored in db
      [ "Layak",             "1" ],
      [ "Tidak Layak",      "2" ]
    ]
  
  
end
