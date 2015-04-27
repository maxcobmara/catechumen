class ExamresultsearchesController < ApplicationController
  def new
    @searchexamresulttype = params[:searchexamresulttype]
    @examresultsearch = Examresultsearch.new
  end

  def create
    @searchexamresulttype = params[:method]
    if @searchexamresulttype == '1' || @searchexamresulttype == 1
      @examresultsearch = Examresultsearch.new(params[:examresultsearch])
    end
    if @examresultsearch.save
      #flash[:notice] = "Successfully created examresultsearch."
      redirect_to @examresultsearch
    else
      render :action => 'new'
    end
  end
  
  def view_semester
    unless params[:programmeid].blank?
      prog_id=params[:programmeid]
      @semesters_prog=Examresult.find(:all, :conditions => ['programme_id=?', prog_id]).map(&:semester)
      @semester_list=[]
      Examresult::SEMESTER.each do |disp ,v |
        @semester_list << [disp,v] if @semesters_prog.include?(v.to_s)
      end
    end
    render :partial => 'view_semester', :layout => false
  end

  def show
    @examresultsearch = Examresultsearch.find(params[:id])
  end
end
