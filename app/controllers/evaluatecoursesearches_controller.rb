class EvaluatecoursesearchesController < ApplicationController
  filter_access_to :all
  def new
    @searchevaluatecoursetype = params[:searchevaluatecoursetype]
    @evaluatecoursesearch = Evaluatecoursesearch.new
    @programme_ids_in_evaluatecourse = EvaluateCourse.all.map(&:course_id).uniq
    @programme_list = Programme.find(:all, :conditions=> ['id IN (?)',@programme_ids_in_evaluatecourse])
    @subject_ids_in_evaluatecourse = EvaluateCourse.all.map(&:subject_id)
    @subject_list = Programme.find(:all, :conditions=> ['id IN (?)', @subject_ids_in_evaluatecourse], :order => 'code ASC')
    @lecturer_ids_in_evaluatecourse = EvaluateCourse.all.map(&:staff_id).uniq
    @lecturer_list = Staff.find(:all, :conditions => ['id IN (?)',@lecturer_ids_in_evaluatecourse], :order =>'name ASC')
  end

  def create
    @searchevaluatecoursetype = params[:method]
    if @searchevaluatecoursetype=='1' || @searchevaluatecoursetype == 1
      @evaluatecoursesearch = Evaluatecoursesearch.new(params[:evaluatecoursesearch])
    end
    if @evaluatecoursesearch.save
      #flash[:notice] = "Successfully created evaluatecoursesearch."
      redirect_to @evaluatecoursesearch
    else
      render :action => 'new'
    end
  end
  
  def view_subject
    subject_ids = EvaluateCourse.all.map(&:subject_id)
    unless params[:programmeid].blank?
      programmeid=params[:programmeid]
      prog_descendants=Programme.find(programmeid).descendants.map(&:id)
      @subject_list = Programme.find(:all, :conditions => ['id IN(?) and id IN(?)', subject_ids, prog_descendants], :order =>"code ASC")
    else
      @subject_list2 = Programme.find(:all, :conditions=>['ancestry_depth=? AND id IN (?)',2,subject_ids], :order =>"code ASC")
    end
    render :partial => 'view_subject', :layout => false
  end
  
  def view_lecturer
     unless params[:subjectid].blank?
      subjectid = params[:subjectid]
      lecturer_ids = EvaluateCourse.find(:all, :conditions=>['subject_id=?', subjectid]).map(&:staff_id).uniq
      @lecturer_list = Staff.find(:all, :conditions => ['id IN(?)', lecturer_ids], :order=> 'name ASC')
    else
      lecturer_ids = EvaluateCourse.all.map(&:staff_id).uniq
      @lecturer_list2 = Staff.find(:all, :conditions => ['id IN(?)', lecturer_ids], :order=> 'name ASC')
    end
    render :partial => 'view_lecturer', :layout => false
  end
  
  def view_invitation
     unless params[:programmeid].blank?
       programmeid=params[:programmeid]
       invitation_names = EvaluateCourse.find(:all, :conditions => ['invite_lec is not null and course_id=?', programmeid]).map(&:invite_lec).uniq
     else
       invitation_names = EvaluateCourse.find(:all, :conditions => ['invite_lec is not null']).map(&:invite_lec).uniq
     end
     @invite_lecturer_list=[]
     invitation_names.each{|x|@invite_lecturer_list << [x, x]}
     render :partial => 'view_invitation', :layout => false
  end

  def show
    @evaluatecoursesearch = Evaluatecoursesearch.find(params[:id])
    current_roles = Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:authname)
    @is_admin=true if current_roles.include?("administration") || current_roles.include?("course_evaluation_module_admin")|| current_roles.include?("course_evaluation_module_viewer")|| current_roles.include?("course_evaluation_module_user")
    @is_lecturer=Role.find(:all, :joins=>:logins, :conditions=>['logins.id=?', Login.current_login.id]).map(&:authname).include?('lecturer')
  end
end
