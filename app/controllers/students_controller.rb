class StudentsController < ApplicationController
  #filter_resource_access
  filter_access_to :all
  # GET /students
  # GET /students.xml
  def index
    submit_val = params[:searchby]
    #@inta2 = Student.with_permissions_to(:index).sort_by{|t|t.intake} #group by program, then sort by intake (first)
    #@inta2 = Student.with_permissions_to(:index).sort_by{|t|t.course_id} #group by intake, then sort by programme (first)
    @inta3 = Student.with_permissions_to(:index).sort_by{|t|t.intake} #sort by intake (before split into pages)
    #@student_intakes = @inta2.group_by { |t| t.intake } #group by program, then sort by intake (first)
    @student_programmes = @inta3.group_by { |t| t.course_id } #group by intake, then sort by programme (first)
		
    #BELOW - group by program, then sort by intake (first)
    #@intake=[] 
		#@student_count=[] 
		#@student_intakes.each do |x,y| 
			#@intake<<x
			#@student_count<< y.count 
      #end 
    
    #BELOW - #group by intake, then sort by programme (first)
		@programme=[] 
		@student_count=[] 
		@student_programmes.each do |x,y| 
			@programme<<x
			@student_count<< y.count 
		end 
    
        if submit_val == "Search" 
            @students = Student.with_permissions_to(:index).search(params[:search]).paginate(:per_page => 20, :page => params[:page])
            #17/11/2011 - Shaliza added pagination for student  
        elsif submit_val == "Search by Intake/Programme"
            @students = Student.with_permissions_to(:index).search2(params[:intake],params[:programme]).paginate(:per_page => 20, :page => params[:page])
            #17/11/2011 - Shaliza added pagination for student
        else
            #@students = @inta2.paginate(:per_page => 20, :page => params[:page])   #before 18Feb2014
            @students = @inta3.paginate(:per_page => 20, :page => params[:page])    #paginate(after sorted by intake) & TO BE group by course(in index) 
        end

    #@students_list = Student.with_permissions_to(:index).all
    
    respond_to do |format|
     # flash[:notice] = "Sorry, your search didn't return any results."
      format.html # index.html.erb
      format.xml  { render :xml => @students }
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
        flash[:notice] = 'Student was successfully created.'
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
        flash[:notice] = 'Student was successfully updated.'
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
  		  if @find_type == "Ethnic Listing by Programme"
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
