class KlassesController < ApplicationController
  # GET /klasses
  # GET /klasses.xml
  def index
    @klasses = Klass.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @klasses }
    end
  end

  # GET /klasses/1
  # GET /klasses/1.xml
  def show
    @klass = Klass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @klass }
    end
  end

  # GET /klasses/new
  # GET /klasses/new.xml
  def new
    @klass = Klass.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @klass }
    end
  end

  # GET /klasses/1/edit
  def edit
    @klass = Klass.find(params[:id])
  end

  # POST /klasses
  # POST /klasses.xml
  def create
    @klass = Klass.new(params[:klass])

    respond_to do |format|
      if @klass.save
        flash[:notice] = 'Klass was successfully created.'
        format.html { redirect_to(@klass) }
        format.xml  { render :xml => @klass, :status => :created, :location => @klass }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @klass.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /klasses/1
  # PUT /klasses/1.xml
  def update
    @klass = Klass.find(params[:id])

    respond_to do |format|
      if @klass.update_attributes(params[:klass])
        flash[:notice] = 'Klass was successfully updated.'
        format.html { redirect_to(@klass) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @klass.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /klasses/1
  # DELETE /klasses/1.xml
  def destroy
    @klass = Klass.find(params[:id])
    @klass.destroy

    respond_to do |format|
      format.html { redirect_to(klasses_url) }
      format.xml  { head :ok }
    end
  end
end
