class TimetablesController < ApplicationController
  # GET /timetables
  # GET /timetables.xml
  def index
    @timetables = Timetable.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timetables }
    end
  end

  # GET /timetables/1
  # GET /timetables/1.xml
  def show
    @timetable = Timetable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timetable }
    end
  end

  # GET /timetables/new
  # GET /timetables/new.xml
  def new
    @timetable = Timetable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timetable }
    end
  end

  # GET /timetables/1/edit
  def edit
    @timetable = Timetable.find(params[:id])
  end

  # POST /timetables
  # POST /timetables.xml
  def create
    @timetable = Timetable.new(params[:timetable])

    respond_to do |format|
      if @timetable.save
        flash[:notice] = 'Timetable was successfully created.'
        format.html { redirect_to(@timetable) }
        format.xml  { render :xml => @timetable, :status => :created, :location => @timetable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timetable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /timetables/1
  # PUT /timetables/1.xml
  def update
    @timetable = Timetable.find(params[:id])

    respond_to do |format|
      if @timetable.update_attributes(params[:timetable])
        flash[:notice] = 'Timetable was successfully updated.'
        format.html { redirect_to(@timetable) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timetable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /timetables/1
  # DELETE /timetables/1.xml
  def destroy
    @timetable = Timetable.find(params[:id])
    @timetable.destroy

    respond_to do |format|
      format.html { redirect_to(timetables_url) }
      format.xml  { head :ok }
    end
  end
  
  def calendar
     @timetables = Timetable.with_permissions_to(:index).find(:all)
     @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today

     respond_to do |format|
       format.html # index.html.erb
       format.xml { render :xml => @timetables }
     end
   end
end
