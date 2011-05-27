class StaffemployschemesController < ApplicationController
  # GET /staffemployschemes
  # GET /staffemployschemes.xml
  def index
    @staffemployschemes = Staffemployscheme.all
    @staffemployschemes_gelas = @staffemployschemes.group_by { |t| t.gelas_name }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staffemployschemes }
    end
  end

  # GET /staffemployschemes/1
  # GET /staffemployschemes/1.xml
  def show
    @staffemployscheme = Staffemployscheme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staffemployscheme }
    end
  end

  # GET /staffemployschemes/new
  # GET /staffemployschemes/new.xml
  def new
    @staffemployscheme = Staffemployscheme.new
    5.times { @staffemployscheme.staffemploygrades.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staffemployscheme }
    end
  end

  # GET /staffemployschemes/1/edit
  def edit
    @staffemployscheme = Staffemployscheme.find(params[:id])
  end

  # POST /staffemployschemes
  # POST /staffemployschemes.xml
  def create
    @staffemployscheme = Staffemployscheme.new(params[:staffemployscheme])

    respond_to do |format|
      if @staffemployscheme.save
        flash[:notice] = 'Staffemployscheme was successfully created.'
        format.html { redirect_to(@staffemployscheme) }
        format.xml  { render :xml => @staffemployscheme, :status => :created, :location => @staffemployscheme }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staffemployscheme.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staffemployschemes/1
  # PUT /staffemployschemes/1.xml
  def update
    @staffemployscheme = Staffemployscheme.find(params[:id])

    respond_to do |format|
      if @staffemployscheme.update_attributes(params[:staffemployscheme])
        flash[:notice] = 'Staffemployscheme was successfully updated.'
        format.html { redirect_to(@staffemployscheme) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staffemployscheme.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /staffemployschemes/1
  # DELETE /staffemployschemes/1.xml
  def destroy
    @staffemployscheme = Staffemployscheme.find(params[:id])
    @staffemployscheme.destroy

    respond_to do |format|
      format.html { redirect_to(staffemployschemes_url) }
      format.xml  { head :ok }
    end
  end
end
