class Analysispaperexam < ActiveRecord::Base
  
   #links to Model Programmes
   belongs_to :course_name,    :class_name => 'Programme', :foreign_key => 'course_id'
   has_many :marks, :dependent => :destroy                                                     
   accepts_nested_attributes_for :marks#, :reject_if => lambda { |a| a[:mark].blank? }   #use of validates_presence_of in mark model
   #links to Model Class
   belongs_to :classroom, :class_name => 'Klass', :foreign_key => 'class_id'

   #links to Model Exammaker
   belongs_to :examname, :class_name => 'Exammaker', :foreign_key => 'exam_id'


   attr_accessor :programme_id
   
   def total_marks
   	  if self.id	
         Mark.sum(:mark, :conditions => ["analysispaperexam_id=?", self.id])
       else
         @total_marks	#any input by user will be ignored either edit form or new (including re-submission-invalid data)
   					          #value assigned from partial..(1) single entry(_form.html.erb-line 44-47) (2) multiple entry(_form_by_paper.html.erb-line88-91)
       end
     end
   
    def self.set_params_value(exammark_list,datatype_for)
         @count_exammark = 0
         exammark_list.each do |exammarkline|
           if @count_exammark == 0 
     			  if datatype_for == 0
     				   return exammarkline.exam_id.to_i              # working format - @try = gradeline.exam1marks.to_i.to_s
             end
           end
           @count_exammark+=1
         end  
  end
   
end
