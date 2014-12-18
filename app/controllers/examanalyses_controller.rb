class ExamanalysesController < ApplicationController
  # GET /examanalyses
  # GET /examanalyses.xml
  def index
    @examanalyses = Examanalysis.all

    #respond_to do |format|
      #format.html # index.html.erb
      #format.xml  { render :xml => @examanalyses }
    #end
    
    ##===
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examanalyses }
      format.xls {send_data @examanalyses.to_xls(:name=>"Exam Paper Analysis",:headers => Examanalysis.header_excel, 
  		:columns => Examanalysis.column_excel ), :file_name => 'exammakeranalysis.xls' }
  		format.pdf do
  			  send_data ExamanalysisDrawer.draw(@examanalyses),:filename => 'examanalysis.pdf', :type=>'application/pdf',:disposition=>'inline'
  		end
    end
    ##===
  end

  # GET /examanalyses/1
  # GET /examanalyses/1.xml
  def show
    @examanalysis = Examanalysis.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examanalysis }
    end
  end

  # GET /examanalyses/new
  # GET /examanalyses/new.xml
  def new
    @examanalysis = Examanalysis.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examanalysis }
    end
  end

  # GET /examanalyses/1/edit
  def edit
    @examanalysis = Examanalysis.find(params[:id])
  end

  # POST /examanalyses
  # POST /examanalyses.xml
  def create
    @examanalysis = Examanalysis.new(params[:examanalysis])

    respond_to do |format|
      if @examanalysis.save
        format.html { redirect_to(@examanalysis, :notice => 'Examanalysis was successfully created.') }
        format.xml  { render :xml => @examanalysis, :status => :created, :location => @examanalysis }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examanalysis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /examanalyses/1
  # PUT /examanalyses/1.xml
  def update
    @examanalysis = Examanalysis.find(params[:id])

    respond_to do |format|
      if @examanalysis.update_attributes(params[:examanalysis])
        format.html { redirect_to(@examanalysis, :notice => 'Examanalysis was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examanalysis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /examanalyses/1
  # DELETE /examanalyses/1.xml
  def destroy
    @examanalysis = Examanalysis.find(params[:id])
    @examanalysis.destroy

    respond_to do |format|
      format.html { redirect_to(examanalyses_url) }
      format.xml  { head :ok }
    end
  end
  
  def view_students_and_marks
    @exam_id = params[:examid]
    unless @exammaker_id.blank? || @exammaker_id.nil? || @exammaker_id == 0 || @exammaker_id == '0'
		  @examquestions = Exam.find(@exammaker_id).examquestions
		  @exammarks= Exammark.find(:all, :order=>"created_at ASC", :conditions=> ['exammaker_id=?', @exammaker_id])
      @exammarks_mark = Examanalysis.set_exammarks_mark(@exammarks)
      @selected_subject = Exam.find(@exammaker_id).subject_id
      @students = Student.available_students2(@selected_subject) 
		  @students_qty = @students.count
		  @student_ca_mse = Examanalysis.set_array(@students,1,@selected_subject)
      @student_exam1marks = Examanalysis.set_array(@students,2,@selected_subject)
      @student_finale = Examranalysis.set_array(@students,3,@selected_subject) 
      @student_NG = Examanalysis.set_array(@students,4,@selected_subject) 
      @student_gred = Examanalysis.set_array(@students,5,@selected_subject)
      @student_grade_by_subject = Examanalysis.set_array(@students,6,@selected_subject)
    end     
    render :partial => 'students_and_marks', :layout => false   
  end
end
