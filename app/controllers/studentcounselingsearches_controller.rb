class StudentcounselingsearchesController < ApplicationController
  def new
    @studentcounselingsearch = Studentcounselingsearch.new
    @searchstudentcounselingtype = params[:searchstudentcounselingtype]
  end

  def create
   #raise params.inspect
    @searchstudentcounselingtype = params[:method]
    if (@searchstudentcounselingtype == '1' || @searchstudentcounselingtype == 1)
      @studentcounselingsearch = Studentcounselingsearch.new(params[:studentcounselingsearch])
    end
    if @studentcounselingsearch.save
      #flash[:notice] = "Successfully created studentcounselingsearch."
      redirect_to @studentcounselingsearch
    else
      render :action => 'new'
    end
  end

  def show
    @studentcounselingsearch = Studentcounselingsearch.find(params[:id])
  end
end
