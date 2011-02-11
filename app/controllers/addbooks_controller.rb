class AddbooksController < ApplicationController
  # GET /addbooks
  # GET /addbooks.xml
  def index
    @addbooks = Addbook.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @addbooks }
    end
  end

  # GET /addbooks/1
  # GET /addbooks/1.xml
  def show
    @addbook = Addbook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @addbook }
    end
  end

  # GET /addbooks/new
  # GET /addbooks/new.xml
  def new
    @addbook = Addbook.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @addbook }
    end
  end

  # GET /addbooks/1/edit
  def edit
    @addbook = Addbook.find(params[:id])
  end

  # POST /addbooks
  # POST /addbooks.xml
  def create
    @addbook = Addbook.new(params[:addbook])

    respond_to do |format|
      if @addbook.save
        flash[:notice] = 'Addbook was successfully created.'
        format.html { redirect_to(@addbook) }
        format.xml  { render :xml => @addbook, :status => :created, :location => @addbook }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @addbook.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /addbooks/1
  # PUT /addbooks/1.xml
  def update
    @addbook = Addbook.find(params[:id])

    respond_to do |format|
      if @addbook.update_attributes(params[:addbook])
        flash[:notice] = 'Addbook was successfully updated.'
        format.html { redirect_to(@addbook) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @addbook.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /addbooks/1
  # DELETE /addbooks/1.xml
  def destroy
    @addbook = Addbook.find(params[:id])
    @addbook.destroy

    respond_to do |format|
      format.html { redirect_to(addbooks_url) }
      format.xml  { head :ok }
    end
  end
end
