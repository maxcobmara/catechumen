class LibrarytransactionsController < ApplicationController
  filter_access_to :all

  # GET /librarytransactions
  # GET /librarytransactions.xml
  def index
    @filters = Librarytransaction::FILTERS
    if params[:show] && @filters.collect{|f| f[:scope]}.include?(params[:show])
      @librarytransactions = Librarytransaction.with_permissions_to.send(params[:show])
    else
      #default to - borrowed items only (as previously requested)
      @librarytransactions = Librarytransaction.with_permissions_to.send("borrowed") 	
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
    @aaa = params[:librarytransactions]
    @staff1 = params[:stafffirst]
    @student1 = params[:studentfirst]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @librarytransaction }
    end
  end

  # GET /librarytransactions/1/edit
  def edit
    @librarytransaction = Librarytransaction.find(params[:id])
  end
  
  def multiple_edit
    render :layout => true
  end

  def multiple_update
    #raise params.inspect
    @update_type=params[:new_submit]
    if @update_type == (t 'librarytransaction.update_all_records') && params[:librarytransaction_ids] #&& params[:librarytransactions] #!= nil
        @librarytransactionsid = params[:librarytransaction_ids]	
        @returneds =params[:returneds]
        @finepays=params[:finepays]
        @fines=params[:fines]
        @returneduedates = params[:returneduedates]
        @librarytransactions = Librarytransaction.find(@librarytransactionsid )
        @count = 0
        @returneds2=[]
        @returneds.each do |x|
            if( x=='1' || x==1) 
              @returneds2 << x
              @count+=1 
            elsif (x=='0' || x==0) 
              if @count == 0
                @returneds2 << x
              end
              @count=0
            end
        end
        #**********
        @librarytransactions.each_with_index do |librarytransaction,index|
    		    librarytransaction.returned = 1 if (@returneds2[index] == '1' || @returneds2[index] == 1)
    		    if (Date.today - Librarytransaction.find(@librarytransactionsid[index]).returnduedate).to_i > 0
    		        if @finepays    #must be ticked, then only it exist (if PAID then INSERT amount paid)
    		            librarytransaction.finepay = 1 if @finepays[index]=='1' || @finepays[index]==1
    		            librarytransaction.fine = @fines[index]
    		        end
  		      end 
    		    librarytransaction.save
        end	
        flash[:notice] = t('librarytransaction.update_multiple_return')
        render(:action => 'multiple_edit',:librarytransactions => @librarytransactions)
        flash.discard
        #**********
    else
        flash[:notice] = t('librarytransaction.select_staff_student_check_loan2')
        redirect_to :action => 'multiple_edit'
    end
  end

  # POST /librarytransactions
  # POST /librarytransactions.xml
  def create
    #raise params.inspect
    @create_type = params[:new_submit]   
    
    if (@create_type == t('librarytransaction.addbook') && params[:librarytransactions] != nil)  #if (@create_type == "Create All Records" && params[:librarytransactions] != nil)
        @librarytransactions = params[:librarytransactions].values.collect { |librarytransaction| Librarytransaction.new(librarytransaction) } 
        @librarytransactions_all = params[:librarytransactions]  
        
        @librarytransactions[0].accession_id = Librarytransaction.get_accession_id(params[:librarytransaction][:accessionbook]) #retrieve autocomplete value & assign
        
        if @librarytransactions.all?(&:valid?) #&& @subject_id_4_all != '0' && @examweight_4_all != '0' && @student_dup_count == 0                                    
			      @librarytransactions.each(&:save!) # ref: to retrieve each value of @grades --> http://railsforum.com/viewtopic.php?id=11557 (Dazen2 007-10-07 05:27:42) 
            flash[:notice] = t('librarytransaction.successfully_save_loan')#'Successfully saved all records' - SAVE ONLY ONE BOOK
            flash.discard
            render(:action => 'new',:librarytransactions => @librarytransactions)
        else                                                                      
            #@gradeerrorsmsg = Grade.set_error_messages(@grades,@subject_id_4_all,@examweight_4_all,@student_dup_count)
			      flash[:error] = @gradeerrorsmsg  #red box                                  
            flash[:notice] = t('librarytransaction.invalid_data_compulsory')
            render(:action => 'new',:librarytransactions => @librarytransactions)
	          flash.discard
	      end
    elsif params[:librarytransaction] != nil #baru tambah - for single transaction only
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
    else
        respond_to do |format|
          if params[:no_quota_bal] == '0' #hidden value assign if checked borrower - quota balance of loan exceed MAXIMUM value (check_availability.html.erb-line 144)
            flash[:notice] = t('librarytransaction.exceed_book_quota')
            format.html{render(:action => 'new',:stafffirst => params[:staff_first], :studentfirst => params[:student_first])}
            flash.discard
          else params[:no_quota_bal] == nil
            flash[:notice] = t('librarytransaction.select_staff_student_check_loan')
            format.html {redirect_to :action => 'new' }
          end
        end 
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
            flash[:notice] = t('librarytransaction.transaction_extend_return') 
            #format.html { redirect_to :action => 'new' }
            format.html{render(:action => 'new',:librarytransaction => @librarytransaction)}
            
            flash.discard
        else
            flash[:notice] =t('librarytransaction.transaction_details')+t('updated')
            format.html { redirect_to(@librarytransaction) }
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @librarytransaction.errors, :status => :unprocessable_entity }
      end
      flash.discard
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
    #raise params.inspect
    if request.post?
      @rustaff = params[:ru_staff].to_s
      @staffsearch = Staff.find_by_name(params[:librarytransaction][:staff_who]) 
      #@staffsearch = params[:staff_search].to_i ##working used before critical updates
      #@studentsearch = Student.find_by_icno(params[:librarytransaction][:student_who]) ##working used before critical updates
      @student_icno_name=params[:librarytransaction][:student_who]
      @student_icno=@student_icno_name.split[0]
      @studentsearch = Student.find_by_icno(@student_icno)
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
  def check_availability2
     if request.post?
        @rustaff = params[:ru_staff].to_s

        if @rustaff == '0'#|| @rustaff == 0
            #@studentsearch = params[:student_search].to_i
            @student_icno_name=params[:librarytransaction][:student_who]
            @student_icno=@student_icno_name.split[0]
            @student_id = Student.find_by_icno(@student_icno).id
            @studentsearch = @student_id.to_i
            @loaned_books = Librarytransaction.find(:all, :conditions=>['student_id=? AND returned IS NOT TRUE', @studentsearch]).count 
            @books_on_loan = Librarytransaction.find(:all, :conditions=>['student_id=? AND returned IS NOT TRUE', @studentsearch])
        else
            #@staffsearch = params[:staff_search].to_i
            @staff_id = Staff.find_by_name(params[:librarytransaction][:staff_who]).id  
            @staffsearch = @staff_id.to_i
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
  
  #def accession_list
    #@bookselect = params[:bookselect]
    #@count = params[:count]
    #@accessions = Book.find(@bookselect).accessions
    #render :partial => 'accession_listing', :layout => false
  #end

  
end
