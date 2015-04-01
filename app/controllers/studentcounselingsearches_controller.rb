class StudentcounselingsearchesController < ApplicationController
  def new
    @studentcounselingsearch = Studentcounselingsearch.new
    @searchstudentcounselingtype = params[:searchstudentcounselingtype]
  end

  def create
    @searchstudentcounselingtype = params[:method]
    if (@searchstudentcounselingtype == '1' || @searchstudentcounselingtype == 1)
      @studentcounselingsearch = Studentcounselingsearch.new(params[:studentcounselingsearch])
      
      ####
      #startdate---
      @aa=params[:confirmed_at_start][:"(1i)"] 
      @bb=params[:confirmed_at_start][:"(2i)"]
      @cc=params[:confirmed_at_start][:"(3i)"]
      if @aa!='' && @bb!='' && @cc!=''
          @dadidu=@aa+'-'+@bb+'-'+@cc  
      else
          @dadidu=''
      end
   
      #--enddate---
      @aa7=params[:confirmed_at_end][:"(1i)"] 
      @bb7=params[:confirmed_at_end][:"(2i)"]
      @cc7=params[:confirmed_at_end][:"(3i)"]
      if @aa7!='' && @bb7!='' && @cc7!=''
          @dadidu7=@aa7+'-'+@bb7+'-'+@cc7  
      else
          @dadidu7=''
      end
      
      @studentcounselingsearch.confirmed_at_start = @dadidu
      @studentcounselingsearch.confirmed_at_end = @dadidu7 
      ####
      
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
