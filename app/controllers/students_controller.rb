class StudentsController < ApplicationController
  #filter_resource_access
  filter_access_to :all
  # GET /students
  # GET /students.xml
  def index
    submit_val = params[:searchby]
    @students3 = Student.search3(params[:search3])
    @inta3 = Student.with_permissions_to(:index).sort_by{|t|t.intake} #sort by intake (before split into pages)
    @student_programmes = @inta3.group_by { |t| t.course_id } #group by intake, then sort by programme (first)
    
    #BELOW - #group by intake, then sort by programme (first)
    @programme=[] 
    @student_count=[] 
    @student_programmes.each do |x,y| 
      @programme<< x
      @student_count<< y.count 
    end 
    
    if submit_val == (t 'search')
      @searched_students = Student.with_permissions_to(:index).search(params[:search])
      @students = @searched_students.paginate(:per_page => 20, :page => params[:page])
    elsif submit_val == I18n.t('student.search_by_intake_programme')
      @searched_students = Student.with_permissions_to(:index).search2(params[:intake],params[:programme])
      @students = @searched_students.paginate(:per_page => 20, :page => params[:page]) #17/11/2011 - Shaliza added pagination for student
    else
      @searched_students = Student.with_permissions_to(:index).find(:all, :order => 'intake ASC, course_id ASC')
      @students = @searched_students.paginate(:per_page => 20, :page => params[:page])
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
      format.xls {send_data @searched_students.to_xls(:name=>"Student Information",:headers => Student.header_excel, :columns => Student.column_excel ), :file_name => 'students.xls' }
      format.js
    end
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new
    @student.qualifications.build
    @student.kins.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end
  
  def formforstudent
     @student = Student.find(params[:id])  
     #@students = Student.search(params[:search])
     render :layout => 'report'
     #respond_to do |format|
         #format.html # index.html.erb  { render :action => "report.css" }
         #format.xml  { render :xml => @staffs }
     #end
  end

  def report  
    @students = Student.search(params[:all])
    @students = Student.find(:all)
    render :layout => 'report'
    
  end
 
  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        flash[:notice] =  t('student.title')+" "+t('created')
        format.html { redirect_to(@student) }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        flash[:notice] =  t('student.title')+" "+t('created')
        format.html { redirect_to(@student) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def ethnic_listing
    if request.post?
      @find_type = params[:list_submit_button]
      if @find_type == I18n.t('student.ethnic_listing')
        @programme_id = params[:programme]
        @students_of_programme = Student.find(:all, :conditions => ['course_id=?',@programme_id ])  
      end
      render :layout => 'report'
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(students_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def maklumat_pelatih_intake
    @students = Student.all
    render :layout => 'report'
  end
end
