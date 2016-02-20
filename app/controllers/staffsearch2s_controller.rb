class Staffsearch2sController < ApplicationController
  filter_resource_access
  def new
    @staffsearch2 = Staffsearch2.new
  end

  def create
   #raise params.inspect
    @staffsearch2 = Staffsearch2.new(params[:staffsearch2])
    if @staffsearch2.keywords=='' && @staffsearch2.position==0 && @staffsearch2.position2==0 && @staffsearch2.position3==0 && @staffsearch2.staff_grade.blank? && @staffsearch2.blank_post==0
      flash[:notice] = t('equery.select_method')
      render :action => 'new'
    else
      if @staffsearch2.save
        #flash[:notice] = "Successfully created staffsearch2."
        redirect_to @staffsearch2
      else
        render :action => 'new'
      end
    end
  end

  def show
    @staffsearch2 = Staffsearch2.find(params[:id])
    @ppp = params[:ppp]
    if @staffsearch2.keywords.blank? && @staffsearch2.position==0 && @staffsearch2.staff_grade.blank? && @staffsearch2.position2==0 && @staffsearch2.position3==0
      @positions = []
    else
      @positions = Position.find(:all, :conditions=>['staffgrade_id IS NOT NULL AND staff_id IN(?) AND name!=?', @staffsearch2.staffs.map(&:id), 'ICMS Vendor Admin'], :order => :ancestry_depth)  
      #@positions = Position.find(:all, :conditions=>['staff_id IN(?) AND name!=?', @staffsearch2.staffs.map(&:id), 'ICMS Vendor Admin'], :order => :ancestry_depth)  
      if @staffsearch2.blank_post==1
        @positions_blank_post=[]
        if @staffsearch2.position==1
          @positions_blank_post+= Position.find(:all, :joins => :staffgrade, :conditions => ['staff_id is NULL AND employgrades.group_id=?', 4])
        end
        if @staffsearch2.position2==1 
          @positions_blank_post+= Position.find(:all, :joins => :staffgrade, :conditions => ['staff_id is NULL AND employgrades.group_id=?', 2])
        end
        if @staffsearch2.position3==1
          @positions_blank_post+= Position.find(:all, :joins => :staffgrade, :conditions => ['staff_id is NULL AND employgrades.group_id=?', 1])
        end
        #when staff_grade or keywords is selected (+all service group), -> result must be within selected staff grade
        if !@staffsearch2.staff_grade.blank? 
          @positions_blank_post= Position.find(:all, :conditions => ['staff_id is NULL AND staffgrade_id=?', @staffsearch2.staff_grade.to_i])
        end
	if !@staffsearch2.keywords.blank? 
          @positions_blank_post= Position.find(:all, :joins=> :staff, :conditions => ['staff_id is NULL AND staffs.name ILIKE(?)', "%#{@staffsearch2.keywords}%"])
        end
        @positions+=@positions_blank_post
      end
    end

    if @ppp=='2'
      @positions2=[]
      #BELOW SAME AS : unless position.staffgrade.blank? && position.postinfo_id.blank?    #must include those w/o butiran - to match with Maklumat Perjawatan
      #@positions_raw = Position.find(:all, :conditions=> ['staffgrade_id IS NOT NULL AND staff_id IN(?) AND name!=?', @staffsearch2.staffs.map(&:id), 'ICMS Vendor Admin']) 
      @positions_raw = @positions
      @positions_raw.group_by{|x|x.staffgrade.name.scan(/[a-zA-Z]+|[0-9]+/)[1].to_i}.sort.reverse!.each do |staffgrade2, positions_of_grade_no|
         positions_of_grade_no.group_by{|x|x.staffgrade.name.scan(/[a-zA-Z]+|[0-9]+/)[0]}.sort.reverse!.each do |staffgrade, positions_by_grade|
           positions_by_grade_w_butiran=[]
           positions_by_grade_wo_butiran=[]
           positions_by_grade.each do |position|
             unless position.postinfo_id.blank? 
               positions_by_grade_w_butiran << position
             else 
               positions_by_grade_wo_butiran << position
             end
           end 
           @positions2.concat(positions_by_grade_w_butiran.sort_by{|x|[x.staffgrade_id, -(x.postinfo.details[0,3].to_i), x.combo_code]})
           #@positions2.concat(positions_by_grade_w_butiran.sort_by{|x|[x.staffgrade_id, x.postinfo_id, x.combo_code]})
           #@positions2.concat(positions_by_grade_w_butiran.sort_by{|x|[x.staffgrade_id, x.postinfo_id, x.staff.name]})
           @positions2.concat(positions_by_grade_wo_butiran.sort_by{|x|[x.staffgrade_id, x.combo_code]})
           #@positions2.concat(positions_by_grade_wo_butiran.sort_by{|x|[x.staffgrade_id, x.staff.name]})
         end
      end
      respond_to do |format|
        format.xls { send_data @positions2.to_xls(:headers=>["BUT.","JAWATAN","GRED","JUM JWT","ISI","HAKIKI","KONTRAK","KUP","KSG","NAMA PENYANDANG","NO.KP/PASSPORT","JANTINA(L/P)","BIDANG KEPAKARAN/SUB-KEPAKARAN","TARIKH WARTA PAKAR","PENEMPATAN","Akt.","Penempatan","Akt.","Penempatan", "CATATAN*"], 
          :columns => [{:postinfo => :details},:name,{:staffgrade=>:name},:totalpost,:occupied_post,:hakiki,:kontrak,:kup,:available_post,{:staff=>[:name,:icno,:jantina]}]) , :filename => 'positions_equery.xls' } 
      end
    else
      render :layout => 'report'
    end
    
  end
end
