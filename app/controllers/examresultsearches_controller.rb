class ExamresultsearchesController < ApplicationController
  def new
    @searchexamresulttype = params[:searchexamresulttype]
    @examresultsearch = Examresultsearch.new
  end

  def create
    @searchexamresulttype = params[:method]
    if @searchexamresulttype == '1' || @searchexamresulttype == 1
        @examresultsearch = Examresultsearch.new(params[:examresultsearch])
         #--exam start date---
          @aa=params[:examdts][:"(1i)"] 
          @bb=params[:examdts][:"(2i)"]
          @cc=params[:examdts][:"(3i)"]
          if @aa!='' && @bb!='' && @cc!=''
              @dadidu=@aa+'-'+@bb+'-'+@cc 
          else
              @dadidu=''
          end
           #--exam start date---
          #--exam end date---
          @aa3=params[:examdte][:"(1i)"] 
          @bb3=params[:examdte][:"(2i)"]
          @cc3=params[:examdte][:"(3i)"]
          if @aa3!='' && @bb3!='' && @cc3!=''
              @dadidu3=@aa3+'-'+@bb3+'-'+@cc3 
          else
              @dadidu3=''
          end
          #--exam end date---
          @examresultsearch.examdts = @dadidu
          @examresultsearch.examdte = @dadidu3
    end
    if @examresultsearch.save
      #flash[:notice] = "Successfully created examresultsearch."
      redirect_to @examresultsearch
    else
      render :action => 'new'
    end
  end

  def show
    @examresultsearch = Examresultsearch.find(params[:id])
  end
end
