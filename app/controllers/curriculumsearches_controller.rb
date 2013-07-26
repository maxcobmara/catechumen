class CurriculumsearchesController < ApplicationController
  def new
    @searchcurriculumtype = params[:searchcurriculumtype]
    @curriculumsearch = Curriculumsearch.new
  end

  def create
    @searchcurriculumtype = params[:method]
    if @searchcurriculumtype == '1' || @searchcurriculumtype == 1
        @curriculumsearch = Curriculumsearch.new(params[:curriculumsearch])
    end
    if @curriculumsearch.save
      #flash[:notice] = "Successfully created curriculumsearch."
      redirect_to @curriculumsearch
    else
      render :action => 'new'
    end
  end

  def show
    @curriculumsearch = Curriculumsearch.find(params[:id])
  end
end
