class StaffsearchesController < ApplicationController
  # GET /staffsearches
  # GET /staffsearches.xml
  #def index
    #@staffsearches = Staffsearch.all

    #respond_to do |format|
      #format.html # index.html.erb
      #format.xml  { render :xml => @staffsearches }
    #end
  #end

  # GET /staffsearches/1
  # GET /staffsearches/1.xml
  def show
    @staffsearch = Staffsearch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staffsearch }
    end
  end

  # GET /staffsearches/new
  # GET /staffsearches/new.xml
  def new
    @staffsearch = Staffsearch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staffsearch }
    end
  end

  # GET /staffsearches/1/edit
  #def edit
    #@staffsearch = Staffsearch.find(params[:id])
  #end

  # POST /staffsearches
  # POST /staffsearches.xml
  #def create
    #@staffsearch = Staffsearch.new(params[:staffsearch])

   # respond_to do |format|
     # if @staffsearch.save
       # format.html { redirect_to(@staffsearch, :notice => 'Staffsearch was successfully created.') }
       # format.xml  { render :xml => @staffsearch, :status => :created, :location => @staffsearch }
      #else
       # format.html { render :action => "new" }
       # format.xml  { render :xml => @staffsearch.errors, :status => :unprocessable_entity }
     # end
   # end
  #end

  # PUT /staffsearches/1
  # PUT /staffsearches/1.xml
  #def update
   # @staffsearch = Staffsearch.find(params[:id])

    #respond_to do |format|
    #  if @staffsearch.update_attributes(params[:staffsearch])
     #   format.html { redirect_to(@staffsearch, :notice => 'Staffsearch was successfully updated.') }
      #  format.xml  { head :ok }
     # else
       # format.html { render :action => "edit" }
       # format.xml  { render :xml => @staffsearch.errors, :status => :unprocessable_entity }
    #  end
  #  end
 # end

  # DELETE /staffsearches/1
  # DELETE /staffsearches/1.xml
  #def destroy
   # @staffsearch = Staffsearch.find(params[:id])
   # @staffsearch.destroy

    #respond_to do |format|
     # format.html { redirect_to(staffsearches_url) }
     # format.xml  { head :ok }
    #end
  #end
end
