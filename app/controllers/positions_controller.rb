class PositionsController < ApplicationController
  # GET /positions
  # GET /positions.xml
  
  def index
    @positions = Position.search(params[:search])
    @staff = Staff.search(params[:search])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @positions }
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
    @position = Position.new(:parent_id => params[:parent_id])

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
        flash[:notice] = t('positions.title')+" "+t('created')
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
        flash[:notice] = t('positions.title')+" "+t('updated')
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
    @ppp = params[:ppp]
    @positions = Position.find(:all, :order => :ancestry_depth)
    if @ppp=='1'
      render :layout => 'report'
    elsif @ppp=='2'
      @positions2=[]
      #BELOW SAME AS : unless position.staffgrade.blank? && position.postinfo_id.blank? 
      @positions_raw = Position.find(:all, :conditions=> ['staffgrade_id IS NOT NULL AND postinfo_id IS NOT NULL']) 
      @positions_raw.group_by{|x|x.staffgrade.name.scan(/[a-zA-Z]+|[0-9]+/)[1].to_i}.sort.reverse!.each do |staffgrade2, positions_of_grade_no|
         positions_of_grade_no.group_by{|x|x.staffgrade.name.scan(/[a-zA-Z]+|[0-9]+/)[0]}.sort.reverse!.each do |staffgrade, positions_by_grade|
           @positions2.concat(positions_by_grade)
         end
      end
      
      respond_to do |format|
        #format.xls { send_data @positions.to_xls, :filename => 'positions.xls' }  #baru OK 
        format.xls { send_data @positions2.to_xls(:headers=>["BUT.","JAWATAN","GRED","JUM JWT","ISI","HAKIKI","KONTRAK","KUP","KSG","NAMA PENYANDANG","NO.KP/PASSPORT","JANTINA(L/P)","BIDANG KEPAKARAN/SUB-KEPAKARAN","TARIKH WARTA PAKAR","PENEMPATAN","Akt.","Penempatan","Akt.","Penempatan", "CATATAN*"], 
          :columns => [{:postinfo => :details},:name,{:staffgrade=>:name},:totalpost,:occupied_post,:available_post,:hakiki,:kontrak,:kup,{:staff=>[:name,:icno,:jantina]}]) , :filename => 'positions.xls' } 
      end
    end
  end
  
end
