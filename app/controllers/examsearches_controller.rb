class ExamsearchesController < ApplicationController
  filter_access_to :all
  def new
    @searchexamtype = params[:searchexamtype]
    @examsearch = Examsearch.new
    valid_subject_ids = Exam.valid_subject_lecturer
    valid_exams = Exam.find(:all, :conditions => ['klass_id is not null AND subject_id IN(?)', valid_subject_ids])
    @subject_ids_in_exam = valid_exams.map(&:subject_id)
    @subject_list = Programme.find(:all, :conditions=>['ancestry_depth=? AND id IN (?) AND id IN(?)',2,@subject_ids_in_exam, valid_subject_ids], :order =>"code ASC")
    @programme_list=[]
    @subject_ids_in_exam.each do |subject|
      @programme_list << Programme.find(subject).root
    end
    @programme_list_ids_uniq = @programme_list.map(&:id).uniq
    @programme_list_rev = Programme.find(@programme_list_ids_uniq) 
    @lecturer_w_exam = valid_exams.map(&:created_by)
    @examtype_array=Exam.examtype_list(valid_exams.map(&:name).uniq)
    @papertype_array=Exam.papertype_list(valid_exams.map(&:klass_id).uniq)
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
      @subject = subjectid
      lecturer_ids = Exam.find(:all, :conditions=>['klass_id is not null and subject_id=?', subjectid]).map(&:created_by)
      @lecturer_list = Staff.find(:all, :conditions => ['id IN(?)', lecturer_ids], :order => 'name ASC')
    else
      lecturer_ids = Exam.find(:all, :conditions=>['klass_id is not null']).map(&:created_by)
      @lecturer_list2 = Staff.find(:all, :conditions => ['id IN(?)', lecturer_ids], :order=> 'name ASC')
    end
    render :partial => 'view_lecturer', :layout => false
  end
  
  def view_examtype
    unless params[:createdby].blank?
      createdby = params[:createdby]
      @creator = createdby
      unless params[:subject].blank?
        subject = params[:subject]
        examtypes = Exam.find(:all, :conditions =>['klass_id is not null and created_by=? and subject_id=?', createdby, subject]).map(&:name).uniq
      else
        ##--restrict examtype displayed for SELECTION by lecturer's PROGRAMME if position got unit
        unit_creator=Position.find(:first, :conditions => ['staff_id=?', createdby]).unit 
        dip_progname=Programme.find(:all, :conditions => ['course_type=? and ancestry_depth=?', 'Diploma', 0]).map(&:name)
        if dip_progname.include?(unit_creator)
          subjects = Programme.find(:first, :conditions => ['name=?', unit_creator]).descendants.at_depth(2).map(&:id)
          examtypes = Exam.find(:all, :conditions =>['klass_id is not null and created_by=? and subject_id IN(?)', createdby, subjects]).map(&:name).uniq
        elsif unit_creator == 'Pos Basik' || unit_creator == 'Diploma Lanjutan' || unit_creator == 'Pengkhususan'
          posbasic_prog=Programme.find(:all, :conditions => ['course_type=? OR course_type=? OR course_type=?', 'Pos Basik', 'Diploma Lanjutan', 'Pengkhususan' ])
          tasks_main = current_login.staff.position.tasks_main
          posbasic_prog.each do |x|
            @programme_id = x.id if tasks_main.include?(x.name)
          end
          subjects = Programme.find(@programme_id).descendants.at_depth(2).map(&:id)
          examtypes = Exam.find(:all, :conditions =>['klass_id is not null and created_by=? and subject_id IN(?)', createdby, subjects]).map(&:name).uniq
        else
          examtypes = Exam.find(:all, :conditions =>['klass_id is not null and created_by=?', createdby]).map(&:name).uniq
        end
        ##--
      end
      @exa=examtypes.count
    else
      examtypes = Exam.find(:all, :conditions =>['klass_id is not null']).map(&:name).uniq
    end
    @examtype_array=Exam.examtype_list(examtypes)
    render :partial => 'view_examtype', :layout => false
  end

  def view_papertype
    valid_subject_ids = Exam.valid_subject_lecturer ##must restrict to valid subjects (lecturer)
    unless params[:examtype2].blank?
      examtype2 = params[:examtype2]
      creator = params[:creator]
      if creator
        klassids = Exam.find(:all, :conditions =>['created_by=? and name=? and subject_id IN(?)', creator, examtype2, valid_subject_ids]).map(&:klass_id).uniq.compact
      else
        klassids = Exam.find(:all, :conditions =>['name=? and subject_id IN(?)', examtype2, valid_subject_ids]).map(&:klass_id).uniq.compact
      end
    else
      klassids = Exam.find(:all, :conditions => ['subject_id IN(?)', valid_subject_ids]).map(&:klass_id).uniq.compact #note-compact exclude null klass_id
    end
    @papertype_array=Exam.papertype_list(klassids)
    render :partial => 'view_papertype', :layout => false
  end  
    
  def show
    @examsearch = Examsearch.find(params[:id])
  end
end
