class StudentdisciplinesearchesController < ApplicationController
  def new
    @searchstudentdisciplinetype = params[:searchstudentdisciplinetype]
    @studentdisciplinesearch = Studentdisciplinesearch.new
  end

  def create
    #raise params.inspect
    @searchstudentdisciplinetype = params[:method]
    if (@searchstudentdisciplinetype == '1' || @searchstudentdisciplinetype == 1)
        @studentdisciplinesearch = Studentdisciplinesearch.new(params[:studentdisciplinesearch])
#         @aa=params[:intake][:"(1i)"] 
#         @bb=params[:intake][:"(2i)"]
#         @cc=params[:intake][:"(3i)"]
#         if @aa!='' && @bb!='' #&& @cc!=''
#             @dadidu=@aa+'-'+@bb+'-'+'01' 
#         else
#             @dadidu=''
#         end
        #@studentdisciplinesearch.intake = params[:intake]#@dadidu
    end
    if @studentdisciplinesearch.save
      #flash[:notice] = "Successfully created studentdisciplinesearch."
      redirect_to @studentdisciplinesearch
    else
      render :action => 'new'
    end
  end
  
  def view_intake
    @programme_id = params[:programmeid]
    a=StudentDisciplineCase.all.map(&:student_id)
    @intakes = Student.find(:all, :conditions => ['course_id=? and id IN(?)', @programme_id, a], :order => 'intake ASC', :select => 'distinct intake, course_id')
    
    render :partial => 'view_intake', :layout => false
  end

  def show
    @studentdisciplinesearch = Studentdisciplinesearch.find(params[:id])
    render :layout => 'report'
  end
end
