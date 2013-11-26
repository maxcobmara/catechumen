class ExamquestionDrawer
  require 'pdf/writer' #------ 14 May 2012 - create pdf for examquestion ----------
	require 'pdf/simpletable'
	
	def self.draw(examquestions)
		#pdf = PDF::Writer.new(:paper => [40,60], :orientation => :landscape)
		pdf = PDF::Writer.new(:paper => "A4", :orientation => :landscape, :font_size =>8)
		pdf.margins_pt(40, 50, 30, 30)  #top, left, bottom, right
		#examquestion_lines = "test"
		#pdf.text examquestion_lines --> will be rendered by line 35 (pdf.render)
		
		row_count = 0
		data_array = []
		examquestions.each do |exmq|
			prog_subj = exmq.curriculum_id? ? exmq.subject_details : ""
			creator = exmq.creator_id? ? exmq.creator_details : ""
			data_array << { "<b>No</b>" => row_count+=1, 
			                "<b>Programme/Subject Code</b>" => prog_subj,  
											"<b>Question Type</b>" => exmq.questiontype,
											"<b>Marks</b>" => exmq.marks.to_s,
											"<b>Category</b>" => exmq.category,
											"<b>Difficulty</b>" => exmq.render_difficulty,
											"<b>Status</b>" => exmq.qstatus,
											"<b>Question</b>" => exmq.question,
											"<b>Answer</b>" => exmq.answer,
											"<b>Creator</b>"=> creator}
		end
		
		#table = PDF::SimpleTable.new
		PDF::SimpleTable.new do |table|
			table.data = data_array
			table.width = 800
  		table.title = "<b>List of Examination Questions</b>"
  		table.column_order = [ "<b>No</b>", "<b>Programme/Subject Code</b>", "<b>Question Type</b>", "<b>Marks</b>","<b>Category</b>","<b>Difficulty</b>","<b>Status</b>","<b>Question</b>","<b>Answer</b>","<b>Creator</b>" ]
  		table.show_lines = :all
  		table.render_on(pdf)
		end		
		
		pdf.render
	end
end

