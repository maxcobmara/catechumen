class TimeTableEntriesController < ApplicationController
  # GET /time_table_entries
  # GET /time_table_entries.xml
  def index
    @time_table_entries = TimeTableEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @time_table_entries }
    end
  end
  
  
  def timetable_view
    @time_table_entries = TimeTableEntry.all
    @period_timing = PeriodTiming.find(:all, :order => :start_time)
    @timetable_week_days = TimetableWeekDay.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @time_table_entries }
    end
    
  end

  # GET /time_table_entries/1
  # GET /time_table_entries/1.xml
  def show
    @time_table_entry = TimeTableEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @time_table_entry }
    end
  end

  # GET /time_table_entries/new
  # GET /time_table_entries/new.xml
  def new
    @time_table_entry = TimeTableEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @time_table_entry }
    end
  end

  # GET /time_table_entries/1/edit
  def edit
    @time_table_entry = TimeTableEntry.find(params[:id])
  end
  
  def select_intake
  @time_table_entry = TimeTableEntry.find(params[:id])  
  
  end

  # POST /time_table_entries
  # POST /time_table_entries.xml
  def create
    @time_table_entry = TimeTableEntry.new(params[:time_table_entry])

    respond_to do |format|
      if @time_table_entry.save
        flash[:notice] = 'TimeTableEntry was successfully created.'
        format.html { redirect_to(@time_table_entry) }
        format.xml  { render :xml => @time_table_entry, :status => :created, :location => @time_table_entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @time_table_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /time_table_entries/1
  # PUT /time_table_entries/1.xml
  def update
    @time_table_entry = TimeTableEntry.find(params[:id])

    respond_to do |format|
      if @time_table_entry.update_attributes(params[:time_table_entry])
        flash[:notice] = 'TimeTableEntry was successfully updated.'
        format.html { redirect_to(@time_table_entry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @time_table_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /time_table_entries/1
  # DELETE /time_table_entries/1.xml
  def destroy
    @time_table_entry = TimeTableEntry.find(params[:id])
    @time_table_entry.destroy

    respond_to do |format|
      format.html { redirect_to(time_table_entries_url) }
      format.xml  { head :ok }
    end
  end
end
