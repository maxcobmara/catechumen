class PositionsController < ApplicationController
  # GET /positions
  # GET /positions.xml
  
  def index
    @positions = Position.search(params[:search])
    @staff = Staff.search(params[:search])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @positions }
      #format.xls {send_data @positions.to_xls(:name=>"Positions",:headers => Position.header_excel, 
  		 # :columns => Position.column_excel ), :file_name => 'positions.xls' }
    end
  end

  # GET /positions/1
  # GET /positions/1.xml
  def show
    @position = Position.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @position }
    end
  end

  # GET /positions/new
  # GET /positions/new.xml
  def new
    @position = Position.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @position }
    end
  end

  # GET /positions/1/edit
  def edit
    @position = Position.find(params[:id])
  end

  # POST /positions
  # POST /positions.xml
  def create
    @position = Position.new(params[:position])

    respond_to do |format|
      if @position.save
        flash[:notice] = 'Position was successfully created.'
        format.html { redirect_to(@position) }
        format.xml  { render :xml => @position, :status => :created, :location => @position }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /positions/1
  # PUT /positions/1.xml
  def update
    @position = Position.find(params[:id])

    respond_to do |format|
      if @position.update_attributes(params[:position])
        flash[:notice] = 'Position was successfully updated.'
        format.html { redirect_to(@position) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @position.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.xml
  def destroy
    @position = Position.find(params[:id])
    @position.destroy

    respond_to do |format|
      format.html { redirect_to(positions_url) }
      format.xml  { head :ok }
    end
  end
  
  def maklumat_perjawatan_LA
    #@pages = Page.find(:all, :order => :position)
    @positions = Position.find(:all, :order => :positioncode)
    respond_to do |format|
      format.html{ render :layout => 'report' }
  
      #---
      #ref:book-pg 465
      #format.xls { send_data @positions.to_xls(:name=>"Positions",:headers => Position.header_excel, :columns => Position.column_excel ), :file_name => 'positions.xls' }
      #format.xls { send_data @positions.to_xls, :file_name => 'positions.xls' }
      format.xls { send_data @positions.to_xls(:title => Position.title_excel,:title2 => Position.title2_excel,:headers => Position.header_excel, :columns => Position.column_excel,:name => 'Positions'), :filename => 'Maklumat_Perjawatan.xls',:type=>'application/vnd.ms-excel' }
      #format.xls { send_data @positions.to_xls, :filename => 'positions2.xls' } #ok but data not properly displayed as required.
      #----
      format.xml { render :xml => @positions }
    end

  end

end
