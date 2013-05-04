class TimetableWeekDaysController < ApplicationController
  # GET /timetable_week_days
  # GET /timetable_week_days.xml
  def index
    @timetable_week_days = TimetableWeekDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timetable_week_days }
    end
  end

  # GET /timetable_week_days/1
  # GET /timetable_week_days/1.xml
  def show
    @timetable_week_day = TimetableWeekDay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timetable_week_day }
    end
  end

  # GET /timetable_week_days/new
  # GET /timetable_week_days/new.xml
  def new
    @timetable_week_day = TimetableWeekDay.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timetable_week_day }
    end
  end

  # GET /timetable_week_days/1/edit
  def edit
    @timetable_week_day = TimetableWeekDay.find(params[:id])
  end

  # POST /timetable_week_days
  # POST /timetable_week_days.xml
  def create
    @timetable_week_day = TimetableWeekDay.new(params[:timetable_week_day])

    respond_to do |format|
      if @timetable_week_day.save
        flash[:notice] = 'TimetableWeekDay was successfully created.'
        format.html { redirect_to(@timetable_week_day) }
        format.xml  { render :xml => @timetable_week_day, :status => :created, :location => @timetable_week_day }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timetable_week_day.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /timetable_week_days/1
  # PUT /timetable_week_days/1.xml
  def update
    @timetable_week_day = TimetableWeekDay.find(params[:id])

    respond_to do |format|
      if @timetable_week_day.update_attributes(params[:timetable_week_day])
        flash[:notice] = 'TimetableWeekDay was successfully updated.'
        format.html { redirect_to(@timetable_week_day) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timetable_week_day.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /timetable_week_days/1
  # DELETE /timetable_week_days/1.xml
  def destroy
    @timetable_week_day = TimetableWeekDay.find(params[:id])
    @timetable_week_day.destroy

    respond_to do |format|
      format.html { redirect_to(timetable_week_days_url) }
      format.xml  { head :ok }
    end
  end
end
