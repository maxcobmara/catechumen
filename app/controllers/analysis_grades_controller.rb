class AnalysisGradesController < ApplicationController
  # GET /analysis_grades
  # GET /analysis_grades.xml
  def index
   # @analysis_grades = AnalysisGrade.all
   @analysis_grades = AnalysisGrade.with_permissions_to(:index)
   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @analysis_grades }
    end
  end

  # GET /analysis_grades/1
  # GET /analysis_grades/1.xml
  def show
    @analysis_grade = AnalysisGrade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @analysis_grade }
    end
  end

  # GET /analysis_grades/new
  # GET /analysis_grades/new.xml
  def new
    @analysis_grade = AnalysisGrade.new
    @analysis_grade.student_marks.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @analysis_grade }
    end
  end

  # GET /analysis_grades/1/edit
  def edit
    @analysis_grade = AnalysisGrade.find(params[:id])
  end

  # POST /analysis_grades
  # POST /analysis_grades.xml
  def create
    @analysis_grade = AnalysisGrade.new(params[:analysis_grade])

    respond_to do |format|
      if @analysis_grade.save
        flash[:notice] = 'AnalysisGrade was successfully created.'
        format.html { redirect_to(@analysis_grade) }
        format.xml  { render :xml => @analysis_grade, :status => :created, :location => @analysis_grade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @analysis_grade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /analysis_grades/1
  # PUT /analysis_grades/1.xml
  def update
    @analysis_grade = AnalysisGrade.find(params[:id])

    respond_to do |format|
      if @analysis_grade.update_attributes(params[:analysis_grade])
        flash[:notice] = 'AnalysisGrade was successfully updated.'
        format.html { redirect_to(@analysis_grade) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @analysis_grade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /analysis_grades/1
  # DELETE /analysis_grades/1.xml
  def destroy
    @analysis_grade = AnalysisGrade.find(params[:id])
    @analysis_grade.destroy

    respond_to do |format|
      format.html { redirect_to(analysis_grades_url) }
      format.xml  { head :ok }
    end
  end
  
  def analysis_form
     @analysis_grade = AnalysisGrade.find(params[:id])
      render :layout => 'report'
  end
  
  def view_class
     @course_id = params[:courseid]
     @klass_id = params[:klassid]
     unless @course_id.blank? 
       @classes = Klass.find(:all, :joins => :programclass,:conditions => ['programme_id=?', @course_id])
     end
     render :partial => 'view_class', :layout => false
   end
end
