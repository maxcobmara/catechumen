class TimetablesController < ApplicationController
  filter_resource_access
  # GET /timetables
  # GET /timetables.xml
  def index
    @timetables = Timetable.search(params[:search])

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
    @timetable.timetable_periods.build
    

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
#raise params.inspect
    @timetable = Timetable.new(params[:timetable])

    respond_to do |format|
      if @timetable.save
        format.html { redirect_to(@timetable, :notice =>  t('timetable.title')+" "+t('created')) }
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
        format.html { redirect_to(@timetable, :notice =>  t('timetable.title')+" "+t('updated')) }
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
end
