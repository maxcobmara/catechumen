class TopicdetailsController < ApplicationController
  # GET /topicdetails
  # GET /topicdetails.xml
  def index
    @topicdetails = Topicdetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topicdetails }
    end
  end

  # GET /topicdetails/1
  # GET /topicdetails/1.xml
  def show
    @topicdetail = Topicdetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topicdetail }
    end
  end

  # GET /topicdetails/new
  # GET /topicdetails/new.xml
  def new
    @topicdetail = Topicdetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topicdetail }
    end
  end

  # GET /topicdetails/1/edit
  def edit
    @topicdetail = Topicdetail.find(params[:id])
  end

  # POST /topicdetails
  # POST /topicdetails.xml
  def create
    @topicdetail = Topicdetail.new(params[:topicdetail])

    respond_to do |format|
      if @topicdetail.save
        format.html { redirect_to(@topicdetail, :notice => 'Topicdetail was successfully created.') }
        format.xml  { render :xml => @topicdetail, :status => :created, :location => @topicdetail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topicdetail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topicdetails/1
  # PUT /topicdetails/1.xml
  def update
    @topicdetail = Topicdetail.find(params[:id])

    respond_to do |format|
      if @topicdetail.update_attributes(params[:topicdetail])
        format.html { redirect_to(@topicdetail, :notice => 'Topicdetail was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topicdetail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topicdetails/1
  # DELETE /topicdetails/1.xml
  def destroy
    @topicdetail = Topicdetail.find(params[:id])
    @topicdetail.destroy

    respond_to do |format|
      format.html { redirect_to(topicdetails_url) }
      format.xml  { head :ok }
    end
  end
end
