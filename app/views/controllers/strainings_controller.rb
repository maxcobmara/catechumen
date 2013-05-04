class StrainingsController < ApplicationController
  # GET /strainings
  # GET /strainings.xml
  def index
    @strainings = Straining.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @strainings }
    end
  end

  # GET /strainings/1
  # GET /strainings/1.xml
  def show
    @straining = Straining.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @straining }
    end
  end

  # GET /strainings/new
  # GET /strainings/new.xml
  def new
    @straining = Straining.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @straining }
    end
  end

  # GET /strainings/1/edit
  def edit
    @straining = Straining.find(params[:id])
  end

  # POST /strainings
  # POST /strainings.xml
  def create
    @straining = Straining.new(params[:straining])

    respond_to do |format|
      if @straining.save
        flash[:notice] = 'Straining was successfully created.'
        format.html { redirect_to(@straining) }
        format.xml  { render :xml => @straining, :status => :created, :location => @straining }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @straining.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /strainings/1
  # PUT /strainings/1.xml
  def update
    @straining = Straining.find(params[:id])

    respond_to do |format|
      if @straining.update_attributes(params[:straining])
        flash[:notice] = 'Straining was successfully updated.'
        format.html { redirect_to(@straining) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @straining.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /strainings/1
  # DELETE /strainings/1.xml
  def destroy
    @straining = Straining.find(params[:id])
    @straining.destroy

    respond_to do |format|
      format.html { redirect_to(strainings_url) }
      format.xml  { head :ok }
    end
  end
end
