class StaffattendancesearchesController < ApplicationController
  def new
    @searchstaffattendancetype = params[:searchattendancetype]
    @staffattendancesearch = Staffattendancesearch.new
  end

  def create
    @searchstaffattendancetype = params[:method]
    if @searchstaffattendancetype == '1' || @searchstaffattendancetype == 1
      @staffattendancesearch = Staffattendancesearch.new(params[:staffattendancesearch])
    end
    if !@staffattendancesearch.department.blank? && !@staffattendancesearch.thumb_id.blank? && !@staffattendancesearch.logged_at.blank?
      if @staffattendancesearch.save
        #flash[:notice] = "Successfully created staffattendancesearch."
        redirect_to @staffattendancesearch
      else
        render :action => 'new'
      end
    else
      flash[:notice] = t('equery.staffattendance.select_all_fields')
      redirect_to new_staffattendancesearch_path(@staffattendancesearch,  :searchattendancetype =>1)
    end
  end
  
  def view_staff
    unless params[:department2].blank?
      department_name = params[:department2]
      thumb_ids=Staff.all.map(&:thumb_id).compact
      @staff_list=Staff.find(:all, :joins => :position, :conditions => ['(unit=? OR tasks_main ILIKE(?)) and thumb_id IN(?) and positions.name!=?', department_name, "%#{department_name}%", thumb_ids,'ICMS Vendor Admin'], :order => 'name ASC')
    end
    render :partial => 'view_staff', :layout => false
  end
  
  def view_monthyear
    unless params[:thumbid].blank?
      thumbid = params[:thumbid]
      @staryear = StaffAttendance.find(:first, :conditions => ['thumb_id=?', thumbid], :order=>'logged_at ASC').logged_at.year
    end
    render :partial => 'view_monthyear', :layout => false
  end
 
  def show
    @staffattendancesearch = Staffattendancesearch.find(params[:id])
  end
end
