class TrainingnotesController < ApplicationController
  # GET /trainingnotes
  # GET /trainingnotes.xml
  def index
    @trainingnotes = Trainingnote.find(:all, :order => 'topic_id')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trainingnotes }
    end
  end

  # GET /trainingnotes/1
  # GET /trainingnotes/1.xml
  def show
    @trainingnote = Trainingnote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trainingnote }
    end
  end

  # GET /trainingnotes/new
  # GET /trainingnotes/new.xml
  def new
    @trainingnote = Trainingnote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trainingnote }
    end
  end

  # GET /trainingnotes/1/edit
  def edit
    @trainingnote = Trainingnote.find(params[:id])
  end

  # POST /trainingnotes
  # POST /trainingnotes.xml
  def create
    @trainingnote = Trainingnote.new(params[:trainingnote])

    respond_to do |format|
      if @trainingnote.save
        flash[:notice] = 'Trainingnote was successfully created.'
        format.html { redirect_to(@trainingnote) }
        format.xml  { render :xml => @trainingnote, :status => :created, :location => @trainingnote }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trainingnote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trainingnotes/1
  # PUT /trainingnotes/1.xml
  def update
    @trainingnote = Trainingnote.find(params[:id])

    respond_to do |format|
      if @trainingnote.update_attributes(params[:trainingnote])
        flash[:notice] = 'Trainingnote was successfully updated.'
        format.html { redirect_to(@trainingnote) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trainingnote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trainingnotes/1
  # DELETE /trainingnotes/1.xml
  def destroy
    @trainingnote = Trainingnote.find(params[:id])
    @trainingnote.destroy

    respond_to do |format|
      format.html { redirect_to(trainingnotes_url) }
      format.xml  { head :ok }
    end
  end
end
