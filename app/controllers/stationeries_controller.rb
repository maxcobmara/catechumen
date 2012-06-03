class StationeriesController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  # GET /stationeries
  # GET /stationeries.xml
  def index
    @stationeries = Stationery.find(:all, :order => sort_column + ' ' + sort_direction, :conditions => ['category ILIKE ?', "%#{params[:search]}%"])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stationeries }
    end
  end

  # GET /stationeries/1
  # GET /stationeries/1.xml
  def show
    @stationery = Stationery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stationery }
    end
  end

  # GET /stationeries/new
  # GET /stationeries/new.xml
  def new
    @stationery = Stationery.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stationery }
    end
  end

  # GET /stationeries/1/edit
  def edit
    @stationery = Stationery.find(params[:id])
  end

  # POST /stationeries
  # POST /stationeries.xml
  def create
    @stationery = Stationery.new(params[:stationery])

    respond_to do |format|
      if @stationery.save
        flash[:notice] = 'Stationery was successfully created.'
        format.html { redirect_to(@stationery) }
        format.xml  { render :xml => @stationery, :status => :created, :location => @stationery }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stationery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stationeries/1
  # PUT /stationeries/1.xml
  def update
    @stationery = Stationery.find(params[:id])

    respond_to do |format|
      if @stationery.update_attributes(params[:stationery])
        flash[:notice] = 'Stationery was successfully updated.'
        format.html { redirect_to(@stationery) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stationery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stationeries/1
  # DELETE /stationeries/1.xml
  def destroy
    @stationery = Stationery.find(params[:id])
    @stationery.destroy

    respond_to do |format|
      format.html { redirect_to(stationeries_url) }
      format.xml  { head :ok }
    end
  end
  
  def kewpa11
       @stationery = Stationery.search(params[:search])
       render :layout => 'report'
  end
  
  def sort_column
      Stationery.column_names.include?(params[:sort]) ? params[:sort] : "code" 
  end
  def sort_direction
      %w[asc desc].include?(params[:direction])? params[:direction] : "asc" 
  end
end
