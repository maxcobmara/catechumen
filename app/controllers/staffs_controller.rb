class StaffsController < ApplicationController
  
  # GET /staffs
  # GET /staffs.xml
def index
  @staffs = Staff.search(params[:search])
  respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staffs }
  end
end

  # GET /staffs/1
  # GET /staffs/1.xml
  def show
    @staff = Staff.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staff }
    end
  end

  # GET /staffs/new
  # GET /staffs/new.xml
  def new
    @staff = Staff.new
    @staff.qualifications.build
    @staff.kins.build
    @staff.loans.build
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staff }
    end
  end

  # GET /staffs/1/edit
  def edit
    @staff = Staff.find(params[:id])
  end
  
  def borang_maklumat_staff
    @staff = Staff.find(params[:id])  
    #@staffs = Staff.search(params[:search])
    render :layout => 'report'
    #respond_to do |format|
        #format.html # index.html.erb  { render :action => "report.css" }
        #format.xml  { render :xml => @staffs }
    #end
  end
  
  #-----Test Ruport---------#
  
def ruport
      table = Staff.report_table(:all, :only => [:id, :name])
        #:only       => %w[icno name id],
        #:conditions => "staffs_id is not null",
        #:group      => "icno, name, id")

    #  grouping = Grouping(table, :by => "icno")

    #  name = Table(%w[platform name count])  

    #  grouping.each do |name,group|
     #   Grouping(group, :by => "name").each do |vname,group|
     #     name     << { "platform" => name, 
     #                   "name" => vname,
     #                   "count" => group.length }
      


    #  sorted_table = name.sort_rows_by("count", :order => :descending)
    #  g = Grouping(sorted_table, :by => "platform")

    #  send_data g.to_pdf,
    #    :type         => "application/pdf",
    #    :disposition  => "inline",
    #    :filename     => "report.pdf" 
    end
  
  
  #---------Test Ruport----#

  # POST /staffs
  # POST /staffs.xml
  def create
    @staff = Staff.new(params[:staff])

    respond_to do |format|
      if @staff.save
        flash[:notice] = t(:thank)
        #flash[:notice] = 'Staff was successfully creat ed.'
        format.html { redirect_to staffs_path }
        format.xml  { render :xml => @staff, :status => :created, :location => @staff }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staffs/1
  # PUT /staffs/1.xml
  def update
    params[:staff][:existing_qualification_attributes] ||= {}
    
    @staff = Staff.find(params[:id])

    respond_to do |format|
      if @staff.update_attributes(params[:staff])
        flash[:notice] = t(:update)
        format.html { redirect_to staff_path(@staff) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.xml
  def destroy
    @staff = Staff.find(params[:id])
    @staff.destroy

    respond_to do |format|
      format.html { redirect_to(staffs_url) }
      format.xml  { head :ok }
    end
  end
end
