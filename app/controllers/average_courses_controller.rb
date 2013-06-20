class AverageCoursesController < ApplicationController
  # GET /average_courses
  # GET /average_courses.xml
  def index
    @average_courses = AverageCourse.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @average_courses }
    end
  end

  # GET /average_courses/1
  # GET /average_courses/1.xml
  def show
    @average_course = AverageCourse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @average_course }
    end
  end

  # GET /average_courses/new
  # GET /average_courses/new.xml
  def new
    @average_course = AverageCourse.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @average_course }
    end
  end

  # GET /average_courses/1/edit
  def edit
    @average_course = AverageCourse.find(params[:id])
  end

  # POST /average_courses
  # POST /average_courses.xml
  def create
    @average_course = AverageCourse.new(params[:average_course])
    @lecturers_subjects=AverageCourse.get_lecturers_subjects  #8March2013
    respond_to do |format|
     if params[:average_course][:lecturer_subject]!=''  
      if @average_course.save
        format.html { redirect_to(@average_course, :notice => 'AverageCourse was successfully created.') }
        format.xml  { render :xml => @average_course, :status => :created, :location => @average_course }
      else
        #format.html { render :action => "new" }
        #format.xml  { render :xml => @average_course.errors, :status => :unprocessable_entity }
        flash[:error] = '<b>Lecturer Name & Subject</b> are compulsory.<br>Please note, only <b>Lecturer Name & Subject</b> with existing Feedback/Course Evaluation are displayed in the list.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @average_lecturer.errors, :status => :unprocessable_entity }
        flash.discard
      end
    end
   end
  end

  # PUT /average_courses/1
  # PUT /average_courses/1.xml
  def update
    @average_course = AverageCourse.find(params[:id])

    respond_to do |format|
      if @average_course.update_attributes(params[:average_course])
        format.html { redirect_to(@average_course, :notice => 'AverageCourse was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @average_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /average_courses/1
  # DELETE /average_courses/1.xml
  def destroy
    @average_course = AverageCourse.find(params[:id])
    @average_course.destroy

    respond_to do |format|
      format.html { redirect_to(average_courses_url) }
      format.xml  { head :ok }
    end
  end
end
