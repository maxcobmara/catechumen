class StudentsearchesController < ApplicationController
  def new
    @searchstudenttype = params[:searchstudenttype]
    @studentsearch = Studentsearch.new
  end

  def create
    #raise params.inspect
    @searchstudenttype = params[:method]
    if (@searchstudenttype == '1' || @searchstudenttype == 1)
        @studentsearch = Studentsearch.new(params[:studentsearch])
      unless params[:intake].blank?
        @aa=params[:intake][:"(1i)"] 
        #@ff
        @bb=params[:intake][:"(2i)"]
        @cc=params[:intake][:"(3i)"]
        #if @aa!='' && @ff!='' 
            #if @ff=='1'||@ff=='2'||@ff=='3'||@ff=='4'||@ff=='5'||@ff=='6'||@ff=='7'||@ff=='8'||@ff=='9'
                #@bb='0'+@ff
            #end
        if @aa!='' && @bb!=''
            @dadidu=@aa+'-'+@bb+'-'+'01'
        else
            @dadidu=''
        end
      end
        #-----
      unless params[:end_training].blank?
        @aa2=params[:end_training][:"(1i)"] 
        @bb2=params[:end_training][:"(2i)"]
        @cc2=params[:end_training][:"(3i)"]
        if @aa2!='' && @bb2!='' && @cc2!=''
            @dadidu2=@aa2+'-'+@bb2+'-'+@cc2
        else
            @dadidu2=''
        end
        #-----
      end  
        #=======
        #@studentsearch.icno = params[:studentsearch][:icno]
        #@studentsearch.name = params[:studentsearch][:name] 
        #@studentsearch.matrixno = params[:studentsearch][:matrixno] 
        #@studentsearch.sstatus = params[:studentsearch][:sstatus] 
        #@studentsearch.ssponsor = params[:studentsearch][:ssponsor] 
        #@studentsearch.mrtlstatuscd = params[:studentsearch][:mrtlstatuscd] 
        #@studentsearch.course_id = params[:studentsearch][:course_id] 
        #@studentsearch.physical = params[:studentsearch][:physical] 
        ##@studentsearch.end_training = params[:studentsearch][:end_training] 
        ##@studentsearch.intake = params[:studentsearch][:intake] 
        #@studentsearch.gender = params[:studentsearch][:gender] 
        #@studentsearch.race = params[:studentsearch][:race] 
        #@studentsearch.bloodtype = params[:studentsearch][:bloodtype] 
        #=======
        @studentsearch.intake = @dadidu#.to_date.strftime("%Y-%m-%d")
        @studentsearch.end_training = @dadidu2#.to_date.strftime("%Y-%m-%d")
    end
    
    if @studentsearch.save
        #flash[:notice] = "Successfully created studentsearch."
        redirect_to @studentsearch
    else
        render :action => 'new'
    end
  end

  def show
    @studentsearch = Studentsearch.find(params[:id])
  end
end
