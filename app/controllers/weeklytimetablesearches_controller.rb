class WeeklytimetablesearchesController < ApplicationController
  def new
    @searchweeklytimetabletype = params[:searchweeklytimetabletype]
    @weeklytimetablesearch = Weeklytimetablesearch.new
    @valid_wtintakes =  @weeklytimetablesearch.validintake_data
  end

  def create
    #raise params.inspect
    @searchweeklytimetabletype = params[:method]
    if @searchweeklytimetabletype =='1' || @searchweeklytimetabletype == 1
        @weeklytimetablesearch = Weeklytimetablesearch.new(params[:weeklytimetablesearch])
    end 
    if @weeklytimetablesearch .save
      #flash[:notice] = "Successfully created personalizetimetablesearch."
      redirect_to @weeklytimetablesearch 
    else
      render :action => 'new'
    end
  end

  def view_preparedby
    @weeklytimetablesearch = Weeklytimetablesearch.new
    @valid_intakes =  @weeklytimetablesearch.validintake_data
    unless params[:programmeid].blank? && params[:intakeid].blank?
      unless params[:programmeid].blank?
        @programme_id = params[:programmeid].to_i
        @preparer_with_exist_schedule = Weeklytimetable.find(:all, :conditions => ['programme_id=? and intake_id IN(?)', @programme_id, @valid_intakes]).map(&:prepared_by).compact.uniq
      else
        @intake_id = params[:intakeid].to_i
        @programme_id = Intake.find(@intake_id).programme_id 
        @preparer_with_exist_schedule = Weeklytimetable.find(:all, :conditions => ['programme_id=? and intake_id=? and intake_id IN(?)', @programme_id, @intake_id, @valid_intakes]).map(&:prepared_by).compact.uniq
      end
      @programme_name = Programme.find(@programme_id).name
      @preparer_list = Staff.find(:all, :conditions =>['id IN(?)', @preparer_with_exist_schedule], :order => 'name ASC')
    end
    render :partial => 'view_preparedby', :layout => false
    
    #@preparer=Position.find(:all, :conditions=>['name ILIKE(?) AND (unit ILIKE(?) OR tasks_main ILIKE(?))',"%Pengajar%", "%#{@programme_name}%", "%#{@programme_name}%"]).map(&:staff_id).compact
  end
  
  def show
    @weeklytimetablesearch = Weeklytimetablesearch.find(params[:id])
  end
end
 
