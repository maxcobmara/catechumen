class WeeklytimetableDetailsController < ApplicationController
  # GET /weeklytimetable_details
  # GET /weeklytimetable_details.xml
  def index
    @weeklytimetable_details = WeeklytimetableDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weeklytimetable_details }
    end
  end

  # GET /weeklytimetable_details/1
  # GET /weeklytimetable_details/1.xml
  def show
    @weeklytimetable_detail = WeeklytimetableDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @weeklytimetable_detail }
    end
  end

  # GET /weeklytimetable_details/new
  # GET /weeklytimetable_details/new.xml
  def new
    @weeklytimetable_detail = WeeklytimetableDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @weeklytimetable_detail }
    end
  end

  # GET /weeklytimetable_details/1/edit
  def edit
    @weeklytimetable_detail = WeeklytimetableDetail.find(params[:id])
  end

  # POST /weeklytimetable_details
  # POST /weeklytimetable_details.xml
  def create
    @weeklytimetable_detail = WeeklytimetableDetail.new(params[:weeklytimetable_detail])

    respond_to do |format|
      if @weeklytimetable_detail.save
        format.html { redirect_to(@weeklytimetable_detail, :notice => 'WeeklytimetableDetail was successfully created.') }
        format.xml  { render :xml => @weeklytimetable_detail, :status => :created, :location => @weeklytimetable_detail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weeklytimetable_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weeklytimetable_details/1
  # PUT /weeklytimetable_details/1.xml
  def update
    @weeklytimetable_detail = WeeklytimetableDetail.find(params[:id])

    respond_to do |format|
      if @weeklytimetable_detail.update_attributes(params[:weeklytimetable_detail])
        format.html { redirect_to(@weeklytimetable_detail, :notice => 'WeeklytimetableDetail was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weeklytimetable_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weeklytimetable_details/1
  # DELETE /weeklytimetable_details/1.xml
  def destroy
    @weeklytimetable_detail = WeeklytimetableDetail.find(params[:id])
    @weeklytimetable_detail.destroy

    respond_to do |format|
      format.html { redirect_to(weeklytimetable_details_url) }
      format.xml  { head :ok }
    end
  end
  
  def quickfill
    @weeklytimetable_detail = WeeklytimetableDetail.new
    render :layout => 'popup'
    #@addbook = Addbook.new(params[:addbook])
    #render :layout => 'popup'
    #@addbook.save
  end
end
