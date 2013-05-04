class ProgrammesController < ApplicationController
  # GET /programmes
  # GET /programmes.xml
  def index
    @programmes = Programme.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @programmes }
    end
  end

  # GET /programmes/1
  # GET /programmes/1.xml
  def show
    @programme = Programme.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @programme }
    end
  end

  # GET /programmes/new
  # GET /programmes/new.xml
  def new
    @programme = Programme.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @programme }
    end
  end

  # GET /programmes/1/edit
  def edit
    @programme = Programme.find(params[:id])
  end

  # POST /programmes
  # POST /programmes.xml
  def create
    @programme = Programme.new(params[:programme])

    respond_to do |format|
      if @programme.save
        flash[:notice] = 'Programme was successfully created.'
        format.html { redirect_to(@programme) }
        format.xml  { render :xml => @programme, :status => :created, :location => @programme }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @programme.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /programmes/1
  # PUT /programmes/1.xml
  def update
    #params[:programme][:subject_ids] ||= []
    @programme = Programme.find(params[:id])

    respond_to do |format|
      if @programme.update_attributes(params[:programme])
        flash[:notice] = 'Programme was successfully updated.'
        format.html { redirect_to(@programme) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @programme.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /programmes/1
  # DELETE /programmes/1.xml
  def destroy
    @programme = Programme.find(params[:id])
    @programme.destroy

    respond_to do |format|
      format.html { redirect_to(programmes_url) }
      format.xml  { head :ok }
    end
  end
end
