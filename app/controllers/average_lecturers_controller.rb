class AverageLecturersController < ApplicationController
  # GET /average_lecturers
  # GET /average_lecturers.xml
  def index
    @average_lecturers = AverageLecturer.all
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @average_lecturers }
    end
  end

  # GET /average_lecturers/1
  # GET /average_lecturers/1.xml
  def show
    @average_lecturer = AverageLecturer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @average_lecturer }
    end
  end

  # GET /average_lecturers/new
  # GET /average_lecturers/new.xml
  def new
    @average_lecturer = AverageLecturer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @average_lecturer }
    end
  end

  # GET /average_lecturers/1/edit
  def edit
    @average_lecturer = AverageLecturer.find(params[:id])
  end

  # POST /average_lecturers
  # POST /average_lecturers.xml
  def create
    @average_lecturer = AverageLecturer.new(params[:average_lecturer])

    respond_to do |format|
      if @average_lecturer.save
        flash[:notice] = 'AverageLecturer was successfully created.'
        format.html { redirect_to(@average_lecturer) }
        format.xml  { render :xml => @average_lecturer, :status => :created, :location => @average_lecturer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @average_lecturer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /average_lecturers/1
  # PUT /average_lecturers/1.xml
  def update
    @average_lecturer = AverageLecturer.find(params[:id])

    respond_to do |format|
      if @average_lecturer.update_attributes(params[:average_lecturer])
        flash[:notice] = 'AverageLecturer was successfully updated.'
        format.html { redirect_to(@average_lecturer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @average_lecturer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /average_lecturers/1
  # DELETE /average_lecturers/1.xml
  def destroy
    @average_lecturer = AverageLecturer.find(params[:id])
    @average_lecturer.destroy

    respond_to do |format|
      format.html { redirect_to(average_lecturers_url) }
      format.xml  { head :ok }
    end
  end
  
  def average_score
     @average_lecturer = AverageLecturer.find(params[:id])
      render :layout => 'report'
  end
end
