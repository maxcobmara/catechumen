class Assetsearch < ActiveRecord::Base
  attr_accessible :assetcode, :assettype, :name, :purchaseprice, :purchasedate, :startdate, :enddate, :category, :assignedto, :bookable, :loandate, :returndate, :location, :defect_asset,:defect_reporter,:defect_processor,:defect_process,:maintainable 
  attr_accessible :maintname, :maintcode, :disposal, :disposaltype, :discardoption, :disposalreport, :disposalcert, :disposalreport2,:loss_start,:loss_end,:loss_cert
  #validates_numericality_of :purchaseprice, :message => "not a number"
  attr_accessor :method, :datetype, :curryear, :locationtype, :defect_type,:persontype,:disposal_for_reports
  
  def assets
    @assets ||= find_assets
  end
  
  private

  def find_assets
    Asset.find(:all, :conditions => conditions,  :order => orders)   
  end

  def purchaseprice_conditions
    ["purchaseprice>=?", purchaseprice] unless purchaseprice.blank?      
  end

  def purchasedate_conditions
    ["purchasedate>=?", purchasedate] unless purchasedate.blank?
    #["purchasedate>=?", "2011-10-19"] unless purchasedate.blank?        #["purchasedate>=?", name] unless name.blank?        #ok
  end  
  
  def startdate_conditions
    ["purchasedate>=?", startdate] unless startdate.blank?
  end
  
  def enddate_conditions  #between 2 dates
    ["purchasedate<=?", enddate] unless enddate.blank?
  end

  def loandetails
    a='id=? ' if AssetLoan.find(:all,:conditions=>['loaned_on=?',loandate]).map(&:asset_id).uniq.count!=0
    #0.upto(AssetLoan.find(:all,:conditions=>['loaned_on=?',"2013-04-23"]).map(&:id).uniq.count-2) do |l|
    0.upto(AssetLoan.find(:all,:conditions=>['loaned_on=?',loandate]).map(&:asset_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a unless loandate.blank?
  end

  def loandate_conditions  #one date only
    [loandetails,AssetLoan.find(:all,:conditions=>['loaned_on=?',loandate]).map(&:asset_id).uniq] unless loandate.blank?
    #[loandetails,AssetLoan.find(:all,:conditions=>['loaned_on=?',"2013-04-23"]).map(&:id).uniq] unless loandate.blank?
    #['id=? OR id=? OR id=? OR id=? OR id=? OR id=? OR id=? ',[37, 38, 39, 40, 41, 42, 43]]  #["loandate=?", loandate] unless enddate.blank?
  end
  
  def loandetails2
    a='id=? ' if AssetLoan.find(:all,:conditions=>['returned_on=?',returndate]).map(&:asset_id).uniq.count!=0
    0.upto(AssetLoan.find(:all,:conditions=>['returned_on=?',returndate]).map(&:asset_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a unless returndate.blank?
  end

  def returndate_conditions  #one date only
    [loandetails2,AssetLoan.find(:all,:conditions=>['returned_on=?',returndate]).map(&:asset_id).uniq] unless returndate.blank?
  end

  def name_conditions
    ["name ILIKE ?", "%#{name}%"] unless name.blank?    #ok
    #["purchaseprice>=?", name] unless name.blank?      #ok
    
  end
  
  def assettype_conditions
     ["assettype =?", assettype] unless assettype.blank?
  end
  
  #def assignedtodetails
   # a='assignedto_id=? AND id=? ' if AssetDefect.all.map(&:asset_id).count!=0
    #0.upto(AssetDefect.all.map(&:asset_id).count-2) do |l|  
    #  a=a+'OR id=? '
    #end 
    #return a unless assignedto.blank?
  #end
  
  def assignedto_conditions 
    #if category == 5  #KEW-PA 7 (search by : assignedto)
        #["assignedto_id=?", assignedto] unless assignedto.blank? 
    #else              #KEW-PA 9 (search by : assignedto)
        #[assignedtodetails, assignedto,AssetDefect.all.map(&:asset_id)] unless assignedto.blank? 
    #end
    ["assignedto_id=?", assignedto] unless assignedto.blank?  #use this condition WITH FILTER FOR asset in ASSETDEFECT DB only - in show page.
  end

  def assetcode_conditions
    #["assetcode =?", assetcode] unless assetcode.blank?    #OK -but did not work if only part of assetcode was entered
    ["assetcode ILIKE ?", "%#{assetcode}%"] unless assetcode.blank?   #ok 
  end
  
  def location_conditions
    ["location_id=?", location] unless location.blank?
  end
  
  def defect_asset_conditions
    ["id=?", AssetDefect.find(defect_asset).asset_id] unless defect_asset.blank?
  end
  
  def defect_details
     a='id=? ' if AssetDefect.find(:all,:conditions=>['reported_by=?',defect_reporter]).map(&:asset_id).uniq.count!=0
     0.upto(AssetDefect.find(:all,:conditions=>['reported_by=?',defect_reporter]).map(&:asset_id).uniq.count-2) do |l|  
       a=a+'OR id=? '
     end 
     return a unless defect_reporter.blank?
  end
  
  def defect_details2
      a='id=? ' if AssetDefect.find(:all,:conditions=>['processed_by=?',defect_processor]).map(&:asset_id).uniq.count!=0
      0.upto(AssetDefect.find(:all,:conditions=>['processed_by=?',defect_processor]).map(&:asset_id).uniq.count-2) do |l|  
        a=a+'OR id=? '
      end 
      return a unless defect_processor.blank?
  end
  
  def defect_reporter_conditions
    [defect_details, AssetDefect.find(:all, :conditions=>['reported_by=?',defect_reporter]).map(&:asset_id).uniq] unless defect_reporter.blank?
    #["id=?",31] unless defect_reporter.blank?
  end

  def defect_processor_conditions
    [defect_details2, AssetDefect.find(:all, :conditions=>['processed_by=?',defect_processor]).map(&:asset_id).uniq] unless defect_processor.blank?
    # ["id=?", AssetDefect.find(defect_processor).asset_id] unless defect_asset.blank?
  end
  
  def defectprocess_details
    a='id=? ' if AssetDefect.find(:all, :conditions=>['process_type=?',defect_process]).map(&:asset_id).uniq.count!=0
    0.upto(AssetDefect.find(:all, :conditions=>['process_type=?',defect_process]).map(&:asset_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a unless defect_process.blank?
  end  
  
  def defect_process_conditions    
    [defectprocess_details, AssetDefect.find(:all, :conditions=>['process_type=?',defect_process]).map(&:asset_id).uniq] unless defect_process.blank?
  end
  
  def maintainable_conditions
      ['is_maintainable is TRUE'] unless maintainable.blank?# && maintainable==false
  end
  
  def maintname_conditions
      ["is_maintainable is TRUE AND (name ILIKE ? OR typename ILIKE ? OR modelname ILIKE ?)", "%#{maintname}%", "%#{maintname}%", "%#{maintname}%"] unless maintname.blank? 
  end
  
  def maintcode_conditions
      ['is_maintainable is TRUE AND assetcode ILIKE ?', "%#{maintcode}%"] unless maintcode.blank?
  end
  
  def disposal_details
    a='id=? ' if AssetDisposal.all.map(&:asset_id).uniq.count!=0
    0.upto(AssetDisposal.all.map(&:asset_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a unless disposal.blank?
  end
  
  def disposal_conditions
      [" ("+disposal_details+")", AssetDisposal.all.map(&:asset_id)] unless disposal.blank?
  end
  
  def disposalcert_details
    a='id=? ' if AssetDisposal.find(:all,:conditions=>['is_disposed is TRUE']).map(&:asset_id).uniq.count!=0
    0.upto(AssetDisposal.find(:all,:conditions=>['is_disposed is TRUE']).map(&:asset_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a unless disposalcert.blank?
  end
  
  def disposalcert_conditions
    [" ("+disposalcert_details+")", AssetDisposal.find(:all,:conditions=>['is_disposed is TRUE']).map(&:asset_id)] unless disposalcert.blank?
  end
  
  def disposalreport_details
    a='id=? ' if AssetDisposal.find(disposalreport.to_s.split(",")).map(&:asset_id).uniq.count!=0
    0.upto(AssetDisposal.find(disposalreport.to_s.split(",")).map(&:asset_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a unless disposalreport.blank?
  end  
  
  def disposalreport_conditions
    #['id=? OR id=?',AssetDisposal.find(discardoption.to_s.split(",")).map(&:asset_id)] unless discardoption.blank?
    [disposalreport_details,AssetDisposal.find(disposalreport.to_s.split(",")).map(&:asset_id)] unless disposalreport.blank?
  end
  
  def disposalreport2_details
    a='id=? ' if AssetDisposal.find(disposalreport2.to_s.split(",")).map(&:asset_id).uniq.count!=0
    0.upto(AssetDisposal.find(disposalreport2.to_s.split(",")).map(&:asset_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a unless disposalreport2.blank?
  end  
  
  def disposalreport2_conditions
    [disposalreport2_details,AssetDisposal.find(disposalreport2.to_s.split(",")).map(&:asset_id)] unless disposalreport2.blank?
  end
  
  def discardoption_details
    a='id=? ' if AssetDisposal.find(:all, :conditions=>['discard_options=?',discardoption]).map(&:asset_id).uniq.count!=0
    0.upto(AssetDisposal.find(:all, :conditions=>['discard_options=?',discardoption]).map(&:asset_id).uniq.count-2) do |l|  
        a=a+'OR id=? '
    end 
    return a unless discardoption.blank?
  end
  
  def discardoption_conditions
    [discardoption_details, AssetDisposal.find(:all, :conditions=>['discard_options=?',discardoption]).map(&:asset_id)] unless discardoption.blank?
  end
  
  def loss_start_details
    a='id=? ' if AssetLoss.find(:all).map(&:asset_id).uniq.count!=0
    0.upto(AssetLoss.find(:all).map(&:asset_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a unless loss_start.blank?
  end  
  
  def loss_start_conditions
    [" ("+loss_start_details+")",AssetLoss.find(:all).map(&:asset_id)] unless loss_start.blank?
  end
  
  def loss_end_details
    a='id=? ' if AssetLoss.find(:all, :conditions=>['endorsed_on IS NOT NULL']).map(&:asset_id).uniq.count!=0
    0.upto(AssetLoss.find(:all, :conditions=>['endorsed_on IS NOT NULL']).map(&:asset_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a unless loss_end.blank?
  end  
  
  def loss_end_conditions
    [" ("+loss_end_details+")",AssetLoss.find(:all, :conditions=>['endorsed_on IS NOT NULL']).map(&:asset_id)] unless loss_end.blank?
  end
  
  def loss_cert_details
    a='id=? ' if AssetLoss.find(:all, :conditions => ['document_id=?', loss_cert]).map(&:asset_id).uniq.count!=0
    0.upto(AssetLoss.find(:all, :conditions => ['document_id=?', loss_cert]).map(&:asset_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a unless loss_cert.blank?
  end
  
  def loss_cert_conditions
    [loss_cert_details,AssetLoss.find(:all, :conditions => ['document_id=?', loss_cert]).map(&:asset_id)] unless loss_cert.blank?
  end
  
  #def disposaltype_details
    #a='id=? ' if AssetDisposal.find(:all, :conditions=>['disposal_type=?', disposaltype]).map(&:asset_id).uniq.count!=0
    #0.upto(AssetDisposal.find(:all, :conditions=>['disposal_type=?', disposaltype]).map(&:asset_id).uniq.count-2) do |l|  
        #a=a+'OR id=? '
    #end 
    #return a unless disposaltype.blank?
  #end
  
  #def disposaltype_conditions
   # [disposaltype_details, AssetDisposal.find(:all, :conditions=>['disposal_type=?',disposaltype]).map(&:asset_id)] unless disposaltype.blank?
  #end
    
  def orders
    "assetcode ASC"# "staffgrade_id ASC"
  end  

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options] #works like OR?????
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end
 
end
