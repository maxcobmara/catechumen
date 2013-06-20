class Examanalysis < ActiveRecord::Base
  #require 'mathn'
  
  validates_uniqueness_of :exam_id, :message => "can be analysed only once."
  has_many :examquestionanalyses, :dependent => :destroy                                                     
  accepts_nested_attributes_for :examquestionanalyses, :reject_if => lambda { |a| a[:examquestion_id].blank? }
  belongs_to :exampaper, :class_name => 'Exam', :foreign_key => 'exam_id'
  
  #ref :https://www.bcg.wisc.edu/webteam/support/ruby/standard_deviation
  #def sum
    #return self.inject(0){|acc,i|acc+i}
  #end
  
  #def self.average(a)
    #return self.inject(0){|acc,i|acc+i}/self.length.to_f
  #end
  def self.set_exammarks_mark(exammarks)
    @exammarks_mark = []
	  exammarks.sort_by{|x|x.studentmark.name}.each do |exammark|
	    @exammarks_mark << exammark.marks
	  end
	  @mark_ids = []
	  @exammarks_mark.each do |mark_exams|
  		 mark_exams.sort! {|a,b| a.id <=> b.id} #sort each student's collection of mark by it's mark_id
  	end
  	return @exammarks_mark
  end
  
  def self.set_array(students_list,no,selected_subject)
    @student_ca_mse = [] 
    @student_exam1marks = [] 
    @student_finale = [] 
    @student_NG = [] 
    @student_gred = []
    @student_grade_by_subject = []
    students_list.each do |student| 
      student.studentgrade.each do |student_grade| 
    		if student_grade.subjectgrade.id == selected_subject.to_i 
      	  @student_ca_mse << student_grade.score.to_f if no == 1  #student_grade.ca_plus_mse.to_f if no == 1
    			@student_exam1marks << student_grade.exam1marks.to_f if no == 2
    			@student_finale << student_grade.finale.to_f if no == 3
    			@student_NG << student_grade.set_NG if no == 4
    			@student_gred << student_grade.set_gred if no == 5
    			@student_grade_by_subject << student_grade if no == 6
    		end 
    	end 
    end
    return @student_ca_mse if no == 1
    return @student_exam1marks if no == 2
    return @student_finale if no == 3
    return @student_NG if no == 4
    return @student_gred if no == 5
    return @student_grade_by_subject if no == 6
  end
  
  def self.statistic_item(column,loop_column)
     @statistic_item = [] 
		 @statistic_item << column.count 
		 @statistic_item << column.min 
		 @statistic_item << column.max 
		 @statistic_item << 0 #--4th array item-array index no:3
		 @statistic_item << @avg = column.inject{|sum, element| sum + element}.to_f/column.size 
		 #--start-standard deviation-->
		 @sum4var = column.inject(0){|sum,element|sum+(element-@avg)**2} 
		 @sample_variance = (1/column.length.to_f * @sum4var).to_f 
		 #@statistic_item <<3
		 @statistic_item << 1#Math.sqrt(@sample_variance).to_f 
		 #--end-standard deviation-->
		 @statistic_item << 0 #--6th array item-array index no:5-->
     #--start-pass-rate--> #pass rate varied for different type of question...should be set in examquestion or shoud have a standard for each type of question.
     @pass_rate = Examanalysis.set_pass_rate(column,loop_column)
		 @statistic_item << @pass_rate 
		 #--end-pass-rate-->
		 @pass_rate == 1 if @pass_rate == 0
		 @statistic_item << (@pass_rate/column.count)*100 
		 return @statistic_item 
  end
  
  #count total of passed from given arrays of marks - view/exammakeranalysis/... & view/examresult/show_stat.html.erb
  def self.set_pass_rate(column,loop_column)
    @pass_rate = 0 
    column.each do |studentcountif_mark| 
      if loop_column == 0 
				 @pass_rate+=1 if studentcountif_mark >= 15      # CA + MSE marks
			 elsif loop_column == 1 
				 @pass_rate+=1 if studentcountif_mark >= 20      # MCQ marks 
			 elsif loop_column == 2 
 				 @pass_rate+=1 if studentcountif_mark >= 1       # MEQ marks (not included in excel)
 			 elsif loop_column == 3 
 				 @pass_rate+=1 if studentcountif_mark >= 2.5     # SEQ marks
 			 elsif loop_column == 5 
  				 @pass_rate+=1 if studentcountif_mark >= 50     # Final Exam & Total Marks
  		 elsif loop_column == 6
    			@pass_rate+=1 if studentcountif_mark >= 2      # NG
			 elsif loop_column == 7
      		@pass_rate+=1 if studentcountif_mark >= 5      # Total SEQ
  		 end
	  end
	  return @pass_rate
  end
  
  def self.statistic_item2(column,loop_column)
    @statistic_item = []
    @rating1 = 0 
    @rating2 = 0 
    @rating3 = 0 
    @rating4 = 0 
    @rating5 = 0 
		 column.each do |studentcountif| 
			 if loop_column == 0 
				 @rating1+=1 if studentcountif == 0      # CA + MSE marks
				 @rating2+=1 if studentcountif < 6
				 @rating3+=1 if studentcountif < 15
				 @rating4+=1 if studentcountif < 24
				 @rating5+=1 if studentcountif <= 30
			 elsif loop_column == 1 
				 @rating1+=1 if studentcountif == 0      # MCQ marks 
				 @rating2+=1 if studentcountif < 8
				 @rating3+=1 if studentcountif < 20
				 @rating4+=1 if studentcountif < 32
				 @rating5+=1 if studentcountif <= 40
			 elsif loop_column == 2   
 				 @rating1+=1 if studentcountif == 0      # MEQ marks
 				 @rating2+=1 if studentcountif < 5
 				 @rating3+=1 if studentcountif < 12.5
 				 @rating4+=1 if studentcountif < 20
 				 @rating5+=1 if studentcountif <= 25
 			 elsif loop_column == 3    
 				 @rating1+=1 if studentcountif == 0      # SEQ marks
  			 @rating2+=1 if studentcountif < 2
  			 @rating3+=1 if studentcountif < 5
  			 @rating4+=1 if studentcountif < 8
  			 @rating5+=1 if studentcountif <= 10
 			 end
		 end
		 @statistic_item << @rating1
		 @statistic_item << @rating2
		 @statistic_item << @rating3
		 @statistic_item << @rating4
		 @statistic_item << @rating5
  end
  
 def self.header_excel
	["Examination Type","Subject","Grade A", "Grade A-", "Grade B+", "Grade B", "Grade B-", "Grade C+","Grade C", "Grade C-","Grade D+", "Grade D", "Grade E"]
 end
 
 def self.column_excel
   [{:exampaper=>[:examtypename,{:subject => :subject_list}]},:gradeA, :gradeAminus, :gradeBplus,:gradeB, :gradeBminus, :gradeCplus,:gradeC, :gradeCminus,:gradeDplus,:gradeD,:gradeE ]
 	
	#[{:exampaper=>[:examtypename,{:examination => :subject_code_with_subject_name}]},:gradeA, :gradeAminus, :gradeBplus,:gradeB, :gradeBminus, :gradeCplus,:gradeC, :gradeCminus,:gradeDplus,:gradeD,:gradeE ]
 end
  
end
