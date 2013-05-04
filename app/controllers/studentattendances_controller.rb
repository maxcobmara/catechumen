class StudentattendancesController < ApplicationController
  # GET /studentattendances
  # GET /studentattendances.xml
  def index
    @studentattendances = Studentattendance.find(:all, :order => 'id ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @studentattendances }
    end
  end

  # GET /studentattendances/1
  # GET /studentattendances/1.xml
  def show
    @studentattendance = Studentattendance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @studentattendance }
    end
  end

  # GET /studentattendances/new
  # GET /studentattendances/new.xml
  def new
    @studentattendance = Studentattendance.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @studentattendance }
    end
  end

  # GET /studentattendances/1/edit
  def edit
    @studentattendance = Studentattendance.find(params[:id])
  end

  # POST /studentattendances
  # POST /studentattendances.xml
  def create
    @studentattendance = Studentattendance.new(params[:studentattendance])

    respond_to do |format|
      if @studentattendance.save
        flash[:notice] = 'Studentattendance was successfully created.'
        format.html { redirect_to(@studentattendance) }
        format.xml  { render :xml => @studentattendance, :status => :created, :location => @studentattendance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @studentattendance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /studentattendances/1
  # PUT /studentattendances/1.xml
  def update
  #  params[:tudentattendance][:student_ids] ||= []
  @studentattendance = Studentattendance.find(params[:id])

    respond_to do |format|
      if @studentattendance.update_attributes(params[:studentattendance])
        flash[:notice] = 'Studentattendance was successfully updated.'
        format.html { redirect_to(@studentattendance) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @studentattendance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /studentattendances/1
  # DELETE /studentattendances/1.xml
  def destroy
    @studentattendance = Studentattendance.find(params[:id])
    @studentattendance.destroy

    respond_to do |format|
      format.html { redirect_to(studentattendances_url) }
      format.xml  { head :ok }
    end
  end
  
  def view_class
     @timetable_id = params[:timetableid]
     @studentattendance_id = params[:studentattendanceid]
     unless @timetable_id.blank? 
       @students = Student.find(:all, :joins => :klasses,:conditions => ['klass_id=?', @timetable_id])
     end
     render :partial => 'view_class', :layout => false
   end
end
