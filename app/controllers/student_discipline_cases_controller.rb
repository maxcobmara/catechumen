class StudentDisciplineCasesController < ApplicationController
  filter_resource_access
  # GET /student_discipline_cases
  # GET /student_discipline_cases.xml
  def index
    #@student_discipline_cases = StudentDisciplineCase.with_permissions_to(:index).find(:all, :order => "reported_on DESC")
    @filters = StudentDisciplineCase::FILTERS
    if params[:show] && @filters.collect{|f| f[:scope]}.include?(params[:show])
      @student_discipline_cases = StudentDisciplineCase.with_permissions_to.send(params[:show])
    else
      @student_discipline_cases = StudentDisciplineCase.with_permissions_to(:index).find(:all, :order => "reported_on DESC")
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @student_discipline_cases }
    end
  end

  # GET /student_discipline_cases/1
  # GET /student_discipline_cases/1.xml
  def show
    @student_discipline_case = StudentDisciplineCase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student_discipline_case }
    end
  end

  # GET /student_discipline_cases/new
  # GET /student_discipline_cases/new.xml
  def new
    @student_discipline_case = StudentDisciplineCase.new
    @student_discipline_case.student_counseling_sessions.build
    @myhod = Position.find(:all, :conditions => ['tasks_main ILIKE (?)', "%Ketua Program%"], :select => :staff_id).map(&:staff_id)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student_discipline_case }
    end
  end

  # GET /student_discipline_cases/1/edit
  def edit
    @student_discipline_case = StudentDisciplineCase.find(params[:id])
  end

  # POST /student_discipline_cases
  # POST /student_discipline_cases.xml
  def create
    @student_discipline_case = StudentDisciplineCase.new(params[:student_discipline_case])
    @myhod = Position.find(:all, :conditions => ['tasks_main ILIKE (?)', "%Ketua Program%"], :select => :staff_id).map(&:staff_id)
    respond_to do |format|
      if @student_discipline_case.save
        format.html { redirect_to(@student_discipline_case, :notice => t('studentdiscipline.registered')) }
        format.xml  { render :xml => @student_discipline_case, :status => :created, :location => @student_discipline_case }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student_discipline_case.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /student_discipline_cases/1
  # PUT /student_discipline_cases/1.xml
  def update
    @student_discipline_case = StudentDisciplineCase.find(params[:id])
    #@student_counseling_session = StudentDisciplineCase.student_counseling_session.new(params[:student_counseling_session])
    

    respond_to do |format|
      if @student_discipline_case.update_attributes(params[:student_discipline_case])
        format.html { redirect_to(@student_discipline_case, :notice => t('studentdiscipline.title2')+" "+t('updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student_discipline_case.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /student_discipline_cases/1
  # DELETE /student_discipline_cases/1.xml
  def destroy
    @student_discipline_case = StudentDisciplineCase.find(params[:id])
   

    respond_to do |format|
      if @student_discipline_case.destroy
        format.html { redirect_to(student_discipline_cases_url) }
        format.xml  { head :ok }
      else
	format.html { redirect_to(student_discipline_cases_url, :notice => StudentDisciplineCase.display_msg(@student_discipline_case.errors))}
        format.xml  { render :xml => @student_discipline_case.errors, :status => :unprocessable_entity }
      end
    end
  end
end
