class LibrarytransactionsController < ApplicationController
  filter_access_to :all
  # GET /librarytransactions
  # GET /librarytransactions.xml
  #def index
    #@librarytransactions = Librarytransaction.all

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @librarytransactions }
    #end
  #end
  
  def index
    @filters = Librarytransaction::FILTERS
    if params[:show] && @filters.collect{|f| f[:scope]}.include?(params[:show])
      @librarytransactions = Librarytransaction.with_permissions_to.send(params[:show])
    else
      @librarytransactions = Librarytransaction.with_permissions_to.all
    end
    @libtran_days =  @librarytransactions.group_by {|t| t.checkoutdate}
  end

  # GET /librarytransactions/1
  # GET /librarytransactions/1.xml
  def show
    @librarytransaction = Librarytransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @librarytransaction }
    end
  end

  # GET /librarytransactions/new
  # GET /librarytransactions/new.xml
  def new
    @librarytransaction = Librarytransaction.new
    @librarytransactions = Array.new(4) #{ Libraryransaction.new }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @librarytransaction }
    end
  end

  # GET /librarytransactions/1/edit
  def edit
    @librarytransaction = Librarytransaction.find(params[:id])
  end

  # POST /librarytransactions
  # POST /librarytransactions.xml
  def create
    #raise params.inspect
    @create_type = params[:new_submit]   
    if @create_type == "Create All Records" 
        @librarytransactions = params[:librarytransactions].values.collect { |librarytransaction| Librarytransaction.new(librarytransaction) } 
        @librarytransactions_all = params[:librarytransactions]  
        
        if @librarytransactions.all?(&:valid?) #&& @subject_id_4_all != '0' && @examweight_4_all != '0' && @student_dup_count == 0                                           
			      @librarytransactions.each(&:save!)                                                 # ref: to retrieve each value of @grades --> http://railsforum.com/viewtopic.php?id=11557 (Dazen2 007-10-07 05:27:42) 
            flash[:notice] = 'Successfully saved all records'
            redirect_to :action => 'new', :student_search => 272 #'index'
            flash.discard
        else                                                                      # if any of 3 conditions at line 69 not fulfill...
            #@gradeerrorsmsg = Grade.set_error_messages(@grades,@subject_id_4_all,@examweight_4_all,@student_dup_count)
			      flash[:error] = @gradeerrorsmsg  #red box                                  
            flash[:notice] = 'Data supplied was invalid. Please insert all data accordingly. All fields are compulsory.'
	          render :action => 'new'
	          flash.discard
	      end
    else  #baru tambah
#---yg asal---        
    @librarytransaction = Librarytransaction.new(params[:librarytransaction])

    respond_to do |format|
      if @librarytransaction.save
        flash[:notice] = 'Librarytransaction was successfully created.'
        format.html { redirect_to(@librarytransaction) }
        format.xml  { render :xml => @librarytransaction, :status => :created, :location => @librarytransaction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @librarytransaction.errors, :status => :unprocessable_entity }
      end
    end
#yg asal--------
    end #baru tambah
  end

  # PUT /librarytransactions/1
  # PUT /librarytransactions/1.xml
  def update
    #raise params.inspect
    @librarytransaction = Librarytransaction.find(params[:id])
    @update_type = params[:extend2_submit]  
      
          
          
    respond_to do |format|
      if @librarytransaction.update_attributes(params[:librarytransaction])
        
        if @update_type == "Extend" || @update_type == "Return"
            flash[:notice] = 'Librarytransaction was successfully updated (Extended/Returned).'
            format.html { redirect_to :action => 'new' }
            flash.discard
        else
            flash[:notice] = 'Librarytransaction was successfully updated.'
            format.html { redirect_to(@librarytransaction) }
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @librarytransaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /librarytransactions/1
  # DELETE /librarytransactions/1.xml
  def destroy
    @librarytransaction = Librarytransaction.find(params[:id])
    @librarytransaction.destroy

    respond_to do |format|
      format.html { redirect_to(librarytransactions_url) }
      format.xml  { head :ok }
    end
  end
  
  def extend
    @librarytransaction = Librarytransaction.find(params[:id])
  end
  
  def extend2
    @librarytransaction = Librarytransaction.find(params[:id])
    render :layout => false
  end
  
  def return
    @librarytransaction = Librarytransaction.find(params[:id])
  end
  
  def return2
    @librarytransaction = Librarytransaction.find(params[:id])
    render :layout => false
  end
  
  def check_availability
    if request.post?
      @rustaff = params[:ru_staff].to_s
      @staffsearch = params[:staff_search].to_i
      @studentsearch = params[:student_search].to_i
      if @rustaff == '0'#|| @rustaff == 0
          @loaned_books = Librarytransaction.find(:all, :conditions=>['student_id=? AND returned IS NOT TRUE', @studentsearch]).count 
          @books_on_loan = Librarytransaction.find(:all, :conditions=>['student_id=? AND returned IS NOT TRUE', @studentsearch])
      else
          @loaned_books = Librarytransaction.find(:all, :conditions=>['staff_id=? AND returned IS NOT TRUE', @staffsearch]).count
          @books_on_loan = Librarytransaction.find(:all, :conditions=>['staff_id=? AND returned IS NOT TRUE', @staffsearch])
      end
    end
    render :layout => false
  end
  
  def form_try
    @nombor = params[:index]
    render :layout => false
  end
  

  
end
