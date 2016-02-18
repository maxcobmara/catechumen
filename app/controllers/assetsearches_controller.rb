class AssetsearchesController < ApplicationController
  filter_resource_access
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
        #--purchasedate2---
        @aa7=params[:purchasedate2][:"(1i)"] 
        @bb7=params[:purchasedate2][:"(2i)"]
        @cc7=params[:purchasedate2][:"(3i)"]
        if @aa7!='' && @bb7!='' && @cc7!=''
            @dadidu7=@aa7+'-'+@bb7+'-'+@cc7  
        else
            @dadidu7=''
        end
        #--purchasedate2---
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
        #--loandate2---
        @aa4b=params[:loandate2][:"(1i)"] 
        @bb4b=params[:loandate2][:"(2i)"]
        @cc4b=params[:loandate2][:"(3i)"]
        if @aa4b!='' && @bb4b!='' && @cc4b!=''
            @dadidu4b=@aa4b+'-'+@bb4b+'-'+@cc4b  
        else
            @dadidu4b=''
        end
        #--loandate2---
        #####
        #--expectedreturndate---
          @aa9=params[:expectedreturndate][:"(1i)"] 
          @bb9=params[:expectedreturndate][:"(2i)"]
          @cc9=params[:expectedreturndate][:"(3i)"]
          if @aa9!='' && @bb9!='' && @cc9!=''
              @dadidu9=@aa9+'-'+@bb9+'-'+@cc9  
          else
              @dadidu9=''
          end
          ####-set loandate as nil when user select to search KEW-PA6 using returndate
          #if @dadidu5!=''
            #@dadidu4=''
          #end
          ####
          #--expectedreturndate---
          #--expectedreturndate2---
            @aa9b=params[:expectedreturndate2][:"(1i)"] 
            @bb9b=params[:expectedreturndate2][:"(2i)"]
            @cc9b=params[:expectedreturndate2][:"(3i)"]
            if @aa9b!='' && @bb9b!='' && @cc9b!=''
                @dadidu9b=@aa9b+'-'+@bb9b+'-'+@cc9b  
            else
                @dadidu9b=''
            end
          #--expectedreturndate2---
        #####
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
          #if @dadidu5!=''
            #@dadidu4=''
          #end
          ####
          #--returndate---
          #--returndate2---
            @aa5b=params[:returndate2][:"(1i)"] 
            @bb5b=params[:returndate2][:"(2i)"]
            @cc5b=params[:returndate2][:"(3i)"]
            if @aa5b!='' && @bb5b!='' && @cc5b!=''
                @dadidu5b=@aa5b+'-'+@bb5b+'-'+@cc5b  
            else
                @dadidu5b=''
            end
            ####-set loandate as nil when user select to search KEW-PA6 using returndate
            if @dadidu5!=''|| @dadidu5b!=''
              @dadidu4=''
              @dadidu4b=''
            end
            ####
            #--returndate2---
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
        #--receiveddate---
        @aa8=params[:receiveddate][:"(1i)"] 
        @bb8=params[:receiveddate][:"(2i)"]
        @cc8=params[:receiveddate][:"(3i)"]
        if @aa8!='' && @bb8!='' && @cc8!=''
            @dadidu8=@aa8+'-'+@bb8+'-'+@cc8  
        else
            @dadidu8=''
        end
        #--receiveddate---
        #--receiveddate2---
        @aa9=params[:receiveddate2][:"(1i)"] 
        @bb9=params[:receiveddate2][:"(2i)"]
        @cc9=params[:receiveddate2][:"(3i)"]
        if @aa9!='' && @bb9!='' && @cc9!=''
            @dadidu9=@aa9+'-'+@bb9+'-'+@cc9  
        else
            @dadidu9=''
        end
        #--receiveddate2---
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
    if (@searchtype=='1'||@searchtype==1)
        @assetsearch.purchasedate = @dadidu
        @assetsearch.purchasedate2 = @dadidu7
    elsif (@searchtype=='2'||@searchtype=='3')
        @assetsearch.startdate = @dadidu2               #purchase date
        @assetsearch.enddate = @dadidu3                 #purchase date
        @assetsearch.receiveddate = @dadidu8
        @assetsearch.receiveddate2 = @dadidu9
    elsif (@searchtype == '6' || @searchtype == 6)
        @assetsearch.startdate = @dadidu6b
        @assetsearch.enddate = @dadidu6a
    elsif (@searchtype=='4'||@searchtype==4)
        if @dadidu4 !=''
        ab=AssetLoan.find(:all,:conditions=>['loaned_on>=? AND is_approved!=?',@dadidu4,false]).map(&:asset_id).uniq
            if ab.count>0 
                @assetsearch.loandate = @dadidu4
            else
                @assetsearch.loandate = ''    #'2010-01-01'
            end
        end
        if @dadidu4b !=''
        ab2=AssetLoan.find(:all,:conditions=>['loaned_on<=? AND is_approved!=?',@dadidu4b,false]).map(&:asset_id).uniq
            if ab2.count>0 
                @assetsearch.loandate2 = @dadidu4b
            else
                @assetsearch.loandate2 = ''    #'2010-01-01'
            end
        end
        if @dadidu5 !=''
        ab3=AssetLoan.find(:all,:conditions=>['returned_on>=? AND is_approved!=?',@dadidu5,false]).map(&:asset_id).uniq
            if ab3.count>0 
                @assetsearch.returndate= @dadidu5
            else
                @assetsearch.returndate = ''    #'2010-01-01'
            end
        end
        if @dadidu5b !=''
        ab4=AssetLoan.find(:all,:conditions=>['returned_on<=? AND is_approved!=?',@dadidu5b,false]).map(&:asset_id).uniq
            if ab4.count>0 
                @assetsearch.returndate2= @dadidu5b
            else
                @assetsearch.returndate2 = ''    #'2010-01-01'
            end
        end
        if @dadidu9 !=''
        ab5=AssetLoan.find(:all,:conditions=>['expected_on>=? AND is_approved!=?',@dadidu9,false]).map(&:asset_id).uniq
            if ab5.count>0 
                @assetsearch.expectedreturndate= @dadidu9
            else
                @assetsearch.expectedreturndate = ''    #'2010-01-01'
            end
        end
        if @dadidu9b !=''
        ab6=AssetLoan.find(:all,:conditions=>['expected_on<=? AND is_approved!=?',@dadidu9b,false]).map(&:asset_id).uniq
            if ab6.count>0 
                @assetsearch.expectedreturndate2 = @dadidu9b
            else
                @assetsearch.expectedreturndate2 = ''    #'2010-01-01'
            end
        end
        
        
        #--backup in case--
        #@assetsearch.loandate = @dadidu4
        #@assetsearch.loandate2 = @dadidu4b
        #@assetsearch.returndate= @dadidu5
        #@assetsearch.returndate2= @dadidu5b
        #@assetsearch.expectedreturndate= @dadidu9
        #@assetsearch.expectedreturndate2= @dadidu9b
    end
    
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
