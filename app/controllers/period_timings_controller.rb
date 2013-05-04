class PeriodTimingsController < ApplicationController
  # GET /period_timings
  # GET /period_timings.xml
  def index
    @period_timings = PeriodTiming.all(:order => :name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @period_timings }
    end
  end

  # GET /period_timings/1
  # GET /period_timings/1.xml
  def show
    @period_timing = PeriodTiming.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @period_timing }
    end
  end

  # GET /period_timings/new
  # GET /period_timings/new.xml
  def new
    @period_timing = PeriodTiming.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @period_timing }
    end
  end

  # GET /period_timings/1/edit
  def edit
    @period_timing = PeriodTiming.find(params[:id])
  end

  # POST /period_timings
  # POST /period_timings.xml
  def create
    @period_timing = PeriodTiming.new(params[:period_timing])

    respond_to do |format|
      if @period_timing.save
        flash[:notice] = 'PeriodTiming was successfully created.'
        format.html { redirect_to(@period_timing) }
        format.xml  { render :xml => @period_timing, :status => :created, :location => @period_timing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @period_timing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /period_timings/1
  # PUT /period_timings/1.xml
  def update
    @period_timing = PeriodTiming.find(params[:id])

    respond_to do |format|
      if @period_timing.update_attributes(params[:period_timing])
        flash[:notice] = 'PeriodTiming was successfully updated.'
        format.html { redirect_to(@period_timing) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @period_timing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /period_timings/1
  # DELETE /period_timings/1.xml
  def destroy
    @period_timing = PeriodTiming.find(params[:id])
    @period_timing.destroy

    respond_to do |format|
      format.html { redirect_to(period_timings_url) }
      format.xml  { head :ok }
    end
  end
end
