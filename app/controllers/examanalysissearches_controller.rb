class ExamanalysissearchesController < ApplicationController
  def new
    @searchexamanalysistype = params[:searchexamanalysistype]
    @examanalysissearch = Examanalysissearch.new
    exam_ids_in_examanalysis = Examanalysis.all.map(&:exam_id)
    subject_ids_in_examanalysis = Exam.find(:all,:conditions=>['id IN (?)', exam_ids_in_examanalysis]).map(&:subject_id).uniq 
    program_ids_of_subject_ids_in_examanalysis=[] 
    subject_ids_in_examanalysis.each do |subject| 
      program_ids_of_subject_ids_in_examanalysis << Programme.find(subject).root_id 
    end
    @programme_list=Programme.find(:all, :conditions=>['id IN (?)', program_ids_of_subject_ids_in_examanalysis]) 
    @subject_list=Programme.find(:all, :conditions=>['id IN (?)',subject_ids_in_examanalysis])
    examtype_in_examanalysis = Exam.find(:all, :conditions => ['id IN (?)', exam_ids_in_examanalysis]).map(&:name).uniq 
    @examtype_array=Exam.examtype_list(examtype_in_examanalysis)
  end

  def create
    @searchexamanalysistype = params[:method]
    if @searchexamanalysistype == '1' || @searchexamanalysistype == 1
        @examanalysissearch = Examanalysissearch.new(params[:examanalysissearch])
    end
    if @examanalysissearch.save
      #flash[:notice] = "Successfully created examanalysissearch."
      redirect_to @examanalysissearch
    else
      render :action => 'new'
    end
  end
  
  def view_subject
    exam_ids = Examanalysis.all.map(&:exam_id)
    subject_ids = Exam.find(exam_ids).map(&:subject_id)
    unless params[:programmeid].blank?
      programmeid=params[:programmeid]
      prog_descendants=Programme.find(programmeid).descendants.map(&:id)
      @subject_list = Programme.find(:all, :conditions => ['id IN(?) and id IN(?)', subject_ids, prog_descendants], :order =>"code ASC")
    else
      @subject_list2 = Programme.find(:all, :conditions=>['ancestry_depth=? AND id IN (?)',2,subject_ids], :order =>"code ASC")
    end
    render :partial => 'view_subject', :layout => false
  end
  
  def view_examtype
    exam_ids_in_examanalysis = Examanalysis.all.map(&:exam_id)
    unless params[:subjectid].blank?
      subjectid = params[:subjectid]
      examtype_in_examanalysis = Exam.find(:all, :conditions => ['subject_id=? and id IN (?)', subjectid, exam_ids_in_examanalysis]).map(&:name).uniq
    else
      examtype_in_examanalysis = Exam.find(:all, :conditions => ['id IN (?)', exam_ids_in_examanalysis]).map(&:name).uniq
    end
    @examtype_array=Exam.examtype_list(examtype_in_examanalysis)
    render :partial => 'view_examtype', :layout => false
  end 

  def show
    @examanalysissearch = Examanalysissearch.find(params[:id])
  end
end
