class CurriculumsearchesController < ApplicationController
  def new
    @searchcurriculumtype = params[:searchcurriculumtype]
    @curriculumsearch = Curriculumsearch.new
    #for programme_id selection
    root_programme_ids = Programme.roots.map(&:id)
    @programme_list = Programme.find(:all, :conditions=> ['id IN(?) and (course_type=? or course_type=? or course_type=? or course_type=?)', root_programme_ids, 'Diploma', 'Diploma Lanjutan', 'Pos Basik', 'Pengkhususan'], :order => 'course_type, name ASC')
  end

  def create
    @searchcurriculumtype = params[:method]
    if @searchcurriculumtype == '1' || @searchcurriculumtype == 1
        @curriculumsearch = Curriculumsearch.new(params[:curriculumsearch])
    end
    if !@curriculumsearch.programme_id.blank? && !@curriculumsearch.semester.blank? 
      if @curriculumsearch.save
        #flash[:notice] = "Successfully created curriculumsearch."
        redirect_to @curriculumsearch
      else
        render :action => 'new'
      end
    else
      flash[:notice] = t('equery.curriculum.select_prog_and_sem')
      redirect_to new_curriculumsearch_path(@curriculumsearch,  :searchcurriculumtype =>1)
    end
  end
  
  def view_semester
    unless params[:programmeid].blank?
      programme_id = params[:programmeid]
      descendants = Programme.find(programme_id).descendants.map(&:id)#.at_depth(1).sort_by{|x|x.name} #course_type=="Semester"
      @semester_list = Programme.find(:all, :conditions => ['id IN(?) and course_type=? and ancestry_depth=?', descendants, 'Semester', 1], :order => 'name ASC')
    end
    render :partial => 'view_semester', :layout => false
  end
 
  def show
    @curriculumsearch = Curriculumsearch.find(params[:id])
  end
end
