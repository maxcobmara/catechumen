class StaffcoursesController < ApplicationController
  # GET /staffcourses
  # GET /staffcourses.xml
  def index
    @staffcourses = Staffcourse.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staffcourses }
    end
  end

  # GET /staffcourses/1
  # GET /staffcourses/1.xml
  def show
    @staffcourse = Staffcourse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staffcourse }
    end
  end

  # GET /staffcourses/new
  # GET /staffcourses/new.xml
  def new
    @staffcourse = Staffcourse.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staffcourse }
    end
  end

  # GET /staffcourses/1/edit
  def edit
    @staffcourse = Staffcourse.find(params[:id])
  end

  # POST /staffcourses
  # POST /staffcourses.xml
  def create
    @staffcourse = Staffcourse.new(params[:staffcourse])

    respond_to do |format|
      if @staffcourse.save
        flash[:notice] = 'Staffcourse was successfully created.'
        format.html { redirect_to(@staffcourse) }
        format.xml  { render :xml => @staffcourse, :status => :created, :location => @staffcourse }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staffcourse.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staffcourses/1
  # PUT /staffcourses/1.xml
  def update
    @staffcourse = Staffcourse.find(params[:id])

    respond_to do |format|
      if @staffcourse.update_attributes(params[:staffcourse])
        flash[:notice] = 'Staffcourse was successfully updated.'
        format.html { redirect_to(@staffcourse) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staffcourse.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /staffcourses/1
  # DELETE /staffcourses/1.xml
  def destroy
    @staffcourse = Staffcourse.find(params[:id])
    @staffcourse.destroy

    respond_to do |format|
      format.html { redirect_to(staffcourses_url) }
      format.xml  { head :ok }
    end
  end
end
