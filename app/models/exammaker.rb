class Exammaker < ActiveRecord::Base
    has_and_belongs_to_many :examquestions
    belongs_to :creatorpaper,    :class_name => 'Staff',   :foreign_key => 'creator_id'
    belongs_to :course_exam,    :class_name => 'Programme',   :foreign_key => 'course_id'
    belongs_to :intake_exam,    :class_name => 'Intake',   :foreign_key => 'intake'
    #Link to model subject
    has_many :subjectexamination, :class_name => 'Subject', :foreign_key => 'subject_id'
    
    has_many :examname, :class_name => 'Analysisgrades', :foreign_key => 'exam_paper_name'
    
    #Link to Model Grade
    has_many :exam_grade,  :class_name => 'Grade', :foreign_key => 'subject_id'
    
    #links to Model analysispaperexam
    has_many :exam_name,    :class_name => 'analysispaperexam', :foreign_key => 'exam_id'
    
    validate :question_exist
    
    def subject_of_exammaker
      "#{Subject.find(subject_id).subject_code_with_subject_name} - #{description}"  #exammaker.examination.subject_code_with_subject_name
    end
    
   # has_many :exampartquetions, :dependent => :destroy
  #  accepts_nested_attributes_for :exampartquetions, :reject_if => lambda { |a| a[:part_name].blank? }, :allow_destroy =>true
    
    def creatorpaper_details
    suid = creator_id.to_a
    exists = Staff.find(:all, :select => "id").map(&:id)
    checker = suid & exists
    
    if creator_id == nil
      ""
    elsif checker == []
      "Staff No Longer Exists"
    else
      creatorpaper.staff_name_with_title
    end
  end
  
  def bil
     v=1
  end
  
  def exam_start_date
    exam_date.strftime("%d-%b-%Y")
  end
  
  def exam_result
     "#{name} (#{exam_start_date})"
  end  
  
   before_save  :capitalize_label

   def capitalize_label
     self.name = name.capitalize
   end
   
   def self.get_obj_questions(subject_id)
       if subject_id
         @subject_rec = Subject.find(subject_id)  
         @objq2 = [] 
         @subject_rec.subject.obj.each_with_index do |subject_question, index|
       		@objq2 << subject_question 
       	end 
       end
       @objq2
     end

     def self.get_mcq_questions(subject_id) 
       if subject_id
         @subject_rec = Subject.find(subject_id)
         @mcqq2 = [] 
         @subject_rec.subject.mcq.each_with_index do |subject_question, index|
         	@mcqq2 << subject_question
         end
       end 
       @mcqq2
     end

     def self.get_tf_questions(subject_id) 
       if subject_id
         @subject_rec = Subject.find(subject_id)
         @tfq2 = [] 
         @subject_rec.subject.tf.each_with_index do |subject_question, index|
         	@tfq2 << subject_question
         end
       end 
       @tfq2
     end
     
     def self.get_seq_questions(subject_id) 
        if subject_id
          @subject_rec = Subject.find(subject_id)
          @seqq2 = [] 
          @subject_rec.subject.essay.each_with_index do |subject_question, index|
          	@seqq2 << subject_question
          end
        end 
        @seqq2
      end
     
     protected 

         def question_exist
     		  #errors.add(:examquestion_ids, "{{value}} not equal to 7, 8, 13") if examquestion_ids != [7,8,13] #["7","8","13"]

     	    #this part works for unselected question of newly selected/change programme whereby previous question record are not 
     	    #part of available question of new selected programme --> Submitted data was not save (invalid)
     	    #@questions_available_test=[8,13]     #value of examquestion_ids ==> [2]:Array ....["2"]  
         	#------------------------------------------------------------------------------------------------------------------------------------------------------------------------
           @questions_available=[]       
           if subject_id
     	      @combine_mcqq_meqq = Exammaker.get_mcq_questions(subject_id)+Exammaker.get_obj_questions(subject_id)
     	  	  for mcqq_meqq in @combine_mcqq_meqq do
         		  @questions_available << mcqq_meqq.id 
         	  end
       	  end
         	errors.add(:examquestion_ids, " was not selected. Upon new selection, previous record of question will be 
         	replaced.") if (examquestion_ids & @questions_available).count==0  #compare array with another array 
         end

     
   
end
