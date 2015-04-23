class ExamsearchesController < ApplicationController
  def new
    @searchexamtype = params[:searchexamtype]
    @examsearch = Examsearch.new
    @subject_ids_in_exam = Exam.find(:all, :conditions => ['klass_id is not null']).map(&:subject_id)
    @subject_list = Programme.find(:all, :conditions=>['ancestry_depth=? AND id IN (?)',2,@subject_ids_in_exam], :order =>"code ASC")
    @programme_list=[]
    @subject_ids_in_exam.each do |subject|
      @programme_list << Programme.find(subject).root
    end
    @programme_list_ids_uniq = @programme_list.map(&:id).uniq
    @programme_list_rev = Programme.find(@programme_list_ids_uniq) 
  end

  def create
    @searchexamtype = params[:method]
    if @searchexamtype == '1' || @searchexamtype == 1
        @examsearch = Examsearch.new(params[:examsearch])
    end
    if @examsearch.save
      #flash[:notice] = "Successfully created examsearch."
      redirect_to @examsearch
    else
      render :action => 'new'
    end
  end
  
  def view_subject
    subject_ids = Exam.find(:all, :conditions =>['klass_id is not null']).map(&:subject_id)
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
      lecturer_ids = Exam.find(:all, :conditions=>['klass_id is not null and subject_id=?', subjectid]).map(&:created_by)
      @lecturer_list = Staff.find(:all, :conditions => ['id IN(?)', lecturer_ids])
    else
      lecturer_ids = Exam.find(:all, :conditions=>['klass_id is not null']).map(&:created_by)
      @lecturer_list2 = Staff.find(:all, :conditions => ['id IN(?)', lecturer_ids])
    end
    render :partial => 'view_lecturer', :layout => false
  end

  def show
    @examsearch = Examsearch.find(params[:id])
  end
end
