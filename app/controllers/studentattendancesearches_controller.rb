class StudentattendancesearchesController < ApplicationController
  def new
      @studentattendancesearch = Studentattendancesearch.new
      @searchstudentattendancetype = params[:searchstudentattendancetype]
  end

  def create
      #raise params.inspect
      @searchstudentattendancetype = params[:method]
      if (@searchstudentattendancetype == '1' || @searchstudentattendancetype == 1)
          @studentattendancesearch = Studentattendancesearch.new(params[:studentattendancesearch])
      end
      if @studentattendancesearch.save
          #flash[:notice] = "Successfully created studentattendancesearch."
          redirect_to @studentattendancesearch
      else
          render :action => 'new'
      end
  end

  def show
      @studentattendancesearch = Studentattendancesearch.find(params[:id])
  end
end
