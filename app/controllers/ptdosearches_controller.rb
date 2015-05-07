class PtdosearchesController < ApplicationController
  def new
    @searchptdotype = params[:searchptdotype]
    @ptdosearch = Ptdosearch.new
    
#Department part - hide 29April2015---listing as staffattendancesearch
#     progdip_name = Programme.find(:all, :conditions => ['course_type=?', 'Diploma'], :order => 'name ASC').map(&:name).uniq.compact
#     progbasic_name=Programme.find(:all, :conditions => ['course_type IN(?)', ['Diploma Lanjutan', 'Pos Basik', 'Pengkhususan']], :order => 'name ASC').map(&:name).uniq.compact
#     other_department_name=Position.find(:all, :conditions => ['unit is not null and unit NOT IN (?) and unit NOT IN (?)', ['Diploma Lanjutan', 'Pos Basik', 'Pengkhususan'], progdip_name], :order => 'unit ASC').map(&:unit).uniq.compact 
#     @department_list=(other_department_name+progdip_name+progbasic_name).sort

  end

  def create
    @searchptdotype = params[:method]
    if @searchptdotype == '1' || @searchptdotype == 1
      @ptdosearch = Ptdosearch.new(params[:ptdosearch])
    end
    #firstdate=Ptschedule.find(:all, :order =>'start ASC').first.start
    #lastdate=Ptschedule.find(:all, :order =>'start ASC').last.start
    #if (@ptdosearch.schedulestart_start && @ptdosearch.schedulestart_start.to_date < firstdate) || (@ptdosearch.schedulestart_end && @ptdosearch.schedulestart_end.to_date > lastdate)
      #flash[:notice]=t('equery.ptdo.date_out_of_range')+firstdate.strftime('%d %b %Y')+" "+t('and')+" "+lastdate.strftime('%d %b %Y')
      #redirect_to new_ptdosearch_path(@ptdosearch,  :searchptdotype =>'1') #@searchptdotype
    #else 
      if @ptdosearch.save
        #flash[:notice] = "Successfully created staffattendancesearch."
        redirect_to @ptdosearch
      else
        #render "new"
        redirect_to new_ptdosearch_path(@ptdosearch,  :searchptdotype =>'1')
      end
    #end 
  end
  
  def view_staff
    unless params[:department2].blank?
      department_name = params[:department2]
      @staff_list=Staff.find(:all, :joins => :position, :conditions => ['(unit=? OR tasks_main ILIKE(?)) and positions.name!=?', department_name, "%#{department_name}%", 'ICMS Vendor Admin'], :order => 'name ASC')
    end
    render :partial => 'view_staff', :layout => false
  end
 
  def show
    @ptdosearch = Ptdosearch.find(params[:id])
    @firstdate=Ptschedule.find(:all, :order =>'start ASC').first.start
    @lastdate=Ptschedule.find(:all, :order =>'start ASC').last.start
  end
end
