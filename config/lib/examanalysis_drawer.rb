class ExamanalysisDrawer
  require 'pdf/writer' #------ 14 May 2012 - create pdf for examquestion ----------
	require 'pdf/simpletable'
	
	def self.draw(examanalyses)
		#pdf = PDF::Writer.new(:paper => [40,60], :orientation => :landscape)
		pdf = PDF::Writer.new(:paper => "A4", :orientation => :landscape, :font_size =>8)
		pdf.margins_pt(40, 50, 30, 30)  #top, left, bottom, right
		#examquestion_lines = "test"
		#pdf.text examquestion_lines --> will be rendered by line 35 (pdf.render)
		
		row_count = 0
		data_array = []
		examanalyses.each do |exmakera|
			exam_type= exmakera.exampaper.name? ? exmakera.exampaper.render_examtype : ""
			subject = exmakera.exampaper.id? ? exmakera.exampaper.subject.name : ""
			data_array << { "<b>No</b>" => row_count+=1, 
			                "<b>Examination Type</b>" => exam_type, 
											"<b>Subject</b>" => subject,
											"<b>Grade A</b>" => exmakera.gradeA,
											"<b>Grade A-</b>" => exmakera.gradeAminus,
											"<b>Grade B+</b>" => exmakera.gradeBplus,
											"<b>Grade B</b>" => exmakera.gradeB,
											"<b>Grade B-</b>" => exmakera.gradeBminus,
											"<b>Grade C+</b>" => exmakera.gradeCplus,
										  "<b>Grade C</b>" => exmakera.gradeC,
											"<b>Grade C-</b>" => exmakera.gradeCminus,
											"<b>Grade D+</b>" => exmakera.gradeDplus,
											"<b>Grade D</b>" => exmakera.gradeD,
											"<b>Grade E</b>"=> exmakera.gradeE}
    end
		
		#table = PDF::SimpleTable.new
		PDF::SimpleTable.new do |table|
			table.data = data_array
			table.width = 800
  		table.title = "<b>Exam Paper Analysis</b>"
  		table.column_order = [ "<b>No</b>", "<b>Examination Type</b>", "<b>Subject</b>", "<b>Grade A</b>","<b>Grade A-</b>","<b>Grade B+</b>","<b>Grade B</b>","<b>Grade B-</b>","<b>Grade C+</b>","<b>Grade C</b>","<b>Grade C-</b>","<b>Grade D+</b>","<b>Grade D</b>","<b>Grade E</b>" ]
  		table.show_lines = :all
  		table.render_on(pdf)
		end		
		
		pdf.render
	end
end

