class AssetsearchesController < ApplicationController
  def new
    @searchtype = params[:searchtype]
    @assetsearch = Assetsearch.new
  end

  def create
    #raise params.inspect
    @searchtype = params[:method]
    if (@searchtype == '1' || @searchtype == 1)
        #--purchasedate---
        @aa=params[:purchasedate][:"(1i)"] 
        @bb=params[:purchasedate][:"(2i)"]
        @cc=params[:purchasedate][:"(3i)"]
        if @aa!='' && @bb!='' && @cc!=''
            @dadidu=@aa+'-'+@bb+'-'+@cc  
        else
            @dadidu=''
        end
        #--purchasedate---
    elsif (@searchtype=='4' || @searchtype==4 )
        #--loandate---
        @aa4=params[:loandate][:"(1i)"] 
        @bb4=params[:loandate][:"(2i)"]
        @cc4=params[:loandate][:"(3i)"]
        if @aa4!='' && @bb4!='' && @cc4!=''
            @dadidu4=@aa4+'-'+@bb4+'-'+@cc4  
        else
            @dadidu4=''
        end
        #--loandate---
         #--returndate---
          @aa5=params[:returndate][:"(1i)"] 
          @bb5=params[:returndate][:"(2i)"]
          @cc5=params[:returndate][:"(3i)"]
          if @aa5!='' && @bb5!='' && @cc5!=''
              @dadidu5=@aa5+'-'+@bb5+'-'+@cc5  
          else
              @dadidu5=''
          end
          ####-set loandate as nil when user select to search KEW-PA6 using returndate
          if @dadidu5!=''
            @dadidu4=''
          end
          ####
          #--returndate---
    elsif (@searchtype=='2'||@searchtype=='3')
        #--startdate---
        @aa2=params[:startdate][:"(1i)"] 
        @bb2=params[:startdate][:"(2i)"]
        @cc2=params[:startdate][:"(3i)"]
        if @aa2!='' && @bb2!='' && @cc2!=''
            @dadidu2=@aa2+'-'+@bb2+'-'+@cc2  
        else
            @dadidu2=''
        end
        #--startdate---
        #--enddate---
        @aa3=params[:enddate][:"(1i)"] 
        @bb3=params[:enddate][:"(2i)"]
        @cc3=params[:enddate][:"(3i)"]
        if @aa3!='' && @bb3!='' && @cc3!=''
            @dadidu3=@aa3+'-'+@bb3+'-'+@cc3  
        else
            @dadidu3=''
        end
        #--enddate---
    elsif (@searchtype == '6' || @searchtype == 6)
        #--purchasedate---
        @aa6=params[:curryear][:"(1i)"] 
        @bb6=params[:curryear][:"(2i)"]
        @cc6=params[:curryear][:"(3i)"]
        if @aa6!='' && @bb6!='' && @cc6!=''
            @dadidu6=@aa6+'-'+@bb6+'-'+@cc6  
            @dadidu6a = @dadidu6.to_date.beginning_of_year+1.year #first day of next year (of selected year)
            #@dadidu6b = @dadidu6.to_date.beginning_of_year
            @dadidu6b = Asset.find(:all, :order=>'purchasedate ASC').map(&:purchasedate).uniq[0].strftime("%Y-%m-%d") #select the earliest date from DB
        else
            @dadidu6=''
        end
        #--purchasedate---
    end
    
    @assetsearch = Assetsearch.new(params[:assetsearch])
    @assetsearch.purchasedate = @dadidu
    if (@searchtype=='2'||@searchtype=='3')
        @assetsearch.startdate = @dadidu2
        @assetsearch.enddate = @dadidu3
    elsif (@searchtype == '6' || @searchtype == 6)
        @assetsearch.startdate = @dadidu6b
        @assetsearch.enddate = @dadidu6a
    end
    @assetsearch.loandate = @dadidu4
    @assetsearch.returndate= @dadidu5
    if (@searchtype=='5'||@searchtype==5)
        @locationtype = params[:assetsearch][:locationtype]
        if @locationtype=="Person In-Charge"
            @assetsearch.location =''
        elsif @locationtype=="Asset Location"
            @assetsearch.assignedto =''
        end 
    end 
    if (@searchtype=='7'||@searchtype==7)
      @defecttype = params[:assetsearch][:defect_type]
      if @defecttype=="Defected Asset"
          @assetsearch.defect_processor ='' 
          @assetsearch.defect_reporter =''
          @assetsearch.assignedto =''
          @assetsearch.defect_process=0 #forcing 0 for string field will result BLANK field
      elsif @defecttype=="Person"
          @assetsearch.defect_asset=''
          @assetsearch.defect_process=0 #forcing 0 for string field will result BLANK field
          @assetsearch.defect_type="Person"
      elsif @defecttype=="Process Type"
          @assetsearch.defect_asset=''
          @assetsearch.assignedto =''
          @assetsearch.defect_processor ='' 
          @assetsearch.defect_reporter =''
      end
    end
    if (@searchtype=='11'||@searchtype==11)
        @disp_disposals = params[:disposal_for_reports]
        @disp_disposals_count = @disp_disposals.count
        @keys = @disp_disposals.keys    #["0", "1"]    ["0", "2"] 
        @keys_array=[]
        0.upto(@disp_disposals_count-1) do |xy|
            @keys_array << @keys[xy]#.to_i
            if xy < @disp_disposals_count-1
              @keys_array << ","
            end
        end
        @assetsearch.disposalreport = @keys_array.to_s
    end 
    if (@searchtype=='14'||@searchtype==14)
        @disp_disposals = params[:disposal_for_yearlyreports]
        @disp_disposals_count = @disp_disposals.count
        @keys = @disp_disposals.keys    #["0", "1"]    ["0", "2"] 
        @keys_array=[]
        0.upto(@disp_disposals_count-1) do |xy|
            @keys_array << @keys[xy]#.to_i
            if xy < @disp_disposals_count-1
              @keys_array << ","
            end
        end
        @assetsearch.disposalreport2 = @keys_array.to_s
    end 
    
    if @assetsearch.save
      #flash[:notice] = "Successfully created assetsearch."
      redirect_to @assetsearch
    else
      render :action => 'new'
    end
  end

  def show
    #raise params.inspect
    @assetsearch = Assetsearch.find(params[:id])
    render :layout => 'report'
  end
end
