class PtcoursesController < ApplicationController
  # GET /ptcourses
  # GET /ptcourses.xml
  def index
    @ptcourses = Ptcourse.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptcourses }
    end
  end

  # GET /ptcourses/1
  # GET /ptcourses/1.xml
  def show
    @ptcourse = Ptcourse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ptcourse }
    end
  end

  # GET /ptcourses/new
  # GET /ptcourses/new.xml
  def new
    @ptcourse = Ptcourse.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ptcourse }
    end
  end

  # GET /ptcourses/1/edit
  def edit
    @ptcourse = Ptcourse.find(params[:id])
  end

  # POST /ptcourses
  # POST /ptcourses.xml
  def create
    @ptcourse = Ptcourse.new(params[:ptcourse])

    respond_to do |format|
      if @ptcourse.save
        flash[:notice] = 'Ptcourse was successfully created.'
        format.html { redirect_to(@ptcourse) }
        format.xml  { render :xml => @ptcourse, :status => :created, :location => @ptcourse }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ptcourse.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ptcourses/1
  # PUT /ptcourses/1.xml
  def update
    @ptcourse = Ptcourse.find(params[:id])

    respond_to do |format|
      if @ptcourse.update_attributes(params[:ptcourse])
        flash[:notice] = 'Ptcourse was successfully updated.'
        format.html { redirect_to(@ptcourse) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ptcourse.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ptcourses/1
  # DELETE /ptcourses/1.xml
  def destroy
    @ptcourse = Ptcourse.find(params[:id])
    @ptcourse.destroy

    respond_to do |format|
      format.html { redirect_to(ptcourses_url) }
      format.xml  { head :ok }
    end
  end
end
