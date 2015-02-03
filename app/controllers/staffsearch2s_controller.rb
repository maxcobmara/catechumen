class Staffsearch2sController < ApplicationController
  def new
    @staffsearch2 = Staffsearch2.new
  end

  def create
    #raise params.inspect
    @staffsearch2 = Staffsearch2.new(params[:staffsearch2])
    if @staffsearch2.save
      #flash[:notice] = "Successfully created staffsearch2."
      redirect_to @staffsearch2
    else
      render :action => 'new'
    end
  end

  def show
    @staffsearch2 = Staffsearch2.find(params[:id])
    @ppp = params[:ppp]
    @positions = Position.find(:all, :conditions=>['staff_id IN(?)', @staffsearch2.staffs.map(&:id)], :order => :ancestry_depth)  #Position.find(:all, :order => :ancestry_depth)

    if @ppp=='2'
      @positions2=[]
      #BELOW SAME AS : unless position.staffgrade.blank? && position.postinfo_id.blank? 
      @positions_raw = Position.find(:all, :conditions=> ['staffgrade_id IS NOT NULL AND postinfo_id IS NOT NULL AND staff_id IN(?)', @staffsearch2.staffs.map(&:id)]) 
      @positions_raw.group_by{|x|x.staffgrade.name.scan(/[a-zA-Z]+|[0-9]+/)[1].to_i}.sort.reverse!.each do |staffgrade2, positions_of_grade_no|
         positions_of_grade_no.group_by{|x|x.staffgrade.name.scan(/[a-zA-Z]+|[0-9]+/)[0]}.sort.reverse!.each do |staffgrade, positions_by_grade|
           @positions2.concat(positions_by_grade)
         end
      end
      respond_to do |format|
        format.xls { send_data @positions2.to_xls(:headers=>["BUT.","JAWATAN","GRED","JUM JWT","ISI","HAKIKI","KONTRAK","KUP","KSG","NAMA PENYANDANG","NO.KP/PASSPORT","JANTINA(L/P)","BIDANG KEPAKARAN/SUB-KEPAKARAN","TARIKH WARTA PAKAR","PENEMPATAN","Akt.","Penempatan","Akt.","Penempatan", "CATATAN*"], 
          :columns => [{:postinfo => :details},:name,{:staffgrade=>:name},:totalpost,:occupied_post,:available_post,:hakiki,:kontrak,:kup,{:staff=>[:name,:icno,:jantina]}]) , :filename => 'positions_equery.xls' } 
      end
    else
      render :layout => 'report'
    end
  end
end
