class LessonplansearchesController < ApplicationController
  def new
    @searchlessonplantype = params[:searchlessonplantype]
    @lessonplansearch = Lessonplansearch.new
  end

  def create
    @searchlessonplantype = params[:method]
    if @searchlessonplantype == '1' || @searchlessonplantype == 1
        @lessonplansearch = Lessonplansearch.new(params[:lessonplansearch])
    end 
    if @lessonplansearch.save
      #flash[:notice] = "Successfully created lessonplansearch."
      redirect_to @lessonplansearch
    else
      render :action => 'new'
    end
  end

  def show
    @lessonplansearch = Lessonplansearch.find(params[:id])
  end
end
