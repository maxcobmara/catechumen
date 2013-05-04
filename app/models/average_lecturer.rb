class AverageLecturer < ActiveRecord::Base
    
    require 'decimal' #20Feb2013-use of gem : ruby-decimal-0.2.2 --> in partial _analysis_details.html.erb
    
belongs_to :lecturer,     :class_name => 'EvaluateLecturer',     :foreign_key => 'lecturer_id'
belongs_to :principal,     :class_name => 'Staff',     :foreign_key => 'principal_id'
belongs_to :subjectavg,      :class_name => 'Subject',   :foreign_key => 'subject_id'

validates_presence_of :programme_id, :subject_id, :lecturer_id  #20Feb2013 - compulsory - in order to worls well with print page
#20Feb2013-
def self.find_evaluations(staff,subject)
  EvaluateLecturer.find(:all, :conditions => ['staff_id=? AND subject_id=?', staff, subject])
end

def self.find_average(staff,subject,itemno)
  @evaluation_results = AverageLecturer.find_evaluations(staff,subject)    #EvaluateLecturer.find(:all, :conditions => ['staff_id=? AND subject_id=?', staff, subject])
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
  if @result_ev.size == 0
    bb = 1
  else
   bb = @result_ev.size
  end
  
  
  
  aa=@result_ev.inject{|sum, element| sum + element}.to_f/bb
  return Decimal(aa.to_s).round
end
#20Feb2013-


CATEGORY = [
    #  Displayed       stored in db
    [ "Layak",             "1" ],
    [ "Tidak Layak",      "2" ]
  ]
end
