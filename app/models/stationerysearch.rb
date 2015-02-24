class Stationerysearch < ActiveRecord::Base
  attr_accessible :product, :document, :issuedby, :receivedby, :received, :received2, :issuedate, :issuedate2

  def stationeries
    @stationeries ||= find_stationeries
  end
  
  private

  def find_stationeries
    Stationery.find(:all, :conditions => conditions,  :order => orders)   
  end
  
  def product_conditions
    #["assetcode =?", assetcode] unless assetcode.blank?    #OK -but did not work if only part of assetcode was entered
    ["category ILIKE (?) or code ILIKE (?)", "%#{product}%", "%#{product}%"] unless product.blank?   #ok 
  end
  
  ################
  def document_details
    exist = StationeryAdd.find(:all,:conditions=>['document ILIKE (?) or lpono ILIKE (?)', "%#{document}%", "%#{document}%"]).count
    a='id=? ' if StationeryAdd.find(:all,:conditions=>['document ILIKE (?) or lpono ILIKE (?)', "%#{document}%", "%#{document}%"]).map(&:stationery_id).uniq.count!=0
    0.upto(StationeryAdd.find(:all,:conditions=>['document ILIKE (?) OR lpono ILIKE (?)', "%#{document}%", "%#{document}%"]).map(&:stationery_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a if exist > 0 && document.blank? == false #unless document.blank?  
  end
  def document_conditions  
    ["( "+document_details+")",StationeryAdd.find(:all,:conditions=>['document ILIKE (?) or lpono ILIKE (?)', "%#{document}%", "%#{document}%"]).map(&:stationery_id).uniq] if (StationeryAdd.find(:all,:conditions=>['document ILIKE (?) or lpono ILIKE (?)', "%#{document}%", "%#{document}%"]).count) > 0 && document.blank? == false #unless document.blank?  
  end

  def received_details
    exist = StationeryAdd.find(:all,:conditions=>['received>=?', received]).count
    a='id=? ' if StationeryAdd.find(:all,:conditions=>['received>=?', received]).map(&:stationery_id).uniq.count!=0
    0.upto(StationeryAdd.find(:all,:conditions=>['received>=?', received]).map(&:stationery_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a if exist > 0 && received.blank? == false
  end
  def received_conditions  
    ["( "+received_details+")", StationeryAdd.find(:all,:conditions=>['received>=?', received]).map(&:stationery_id).uniq] if (StationeryAdd.find(:all,:conditions=>['received>=?', received]).count) > 0 && received.blank? == false 
  end

  def received2_details
    exist = StationeryAdd.find(:all,:conditions=>['received<=?', received2]).count
    a='id=? ' if StationeryAdd.find(:all,:conditions=>['received<=?', received2]).map(&:stationery_id).uniq.count!=0
    0.upto(StationeryAdd.find(:all,:conditions=>['received<=?', received2]).map(&:stationery_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a if exist > 0 && received2.blank? == false
  end
  def received2_conditions  
    ["( "+received2_details+")", StationeryAdd.find(:all,:conditions=>['received<=?', received2]).map(&:stationery_id).uniq] if (StationeryAdd.find(:all,:conditions=>['received<=?', received2]).count) > 0 && received2.blank? == false 
  end
  
  #-------
  
  def issuedate_details
    exist = StationeryUse.find(:all,:conditions=>['issuedate>=?', issuedate]).count
    a='id=? ' if StationeryUse.find(:all,:conditions=>['issuedate>=?', issuedate]).map(&:stationery_id).uniq.count!=0
    0.upto(StationeryUse.find(:all,:conditions=>['issuedate>=?', issuedate]).map(&:stationery_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a if exist > 0 && issuedate.blank? == false
  end
  def issuedate_conditions  
    ["( "+issuedate_details+")", StationeryUse.find(:all,:conditions=>['issuedate>=?', issuedate]).map(&:stationery_id).uniq] if (StationeryUse.find(:all,:conditions=>['issuedate>=?', issuedate]).count) > 0 && issuedate.blank? == false 
  end

  def issuedate2_details
    exist = StationeryUse.find(:all,:conditions=>['issuedate<=?', issuedate2]).count
    a='id=? ' if StationeryUse.find(:all,:conditions=>['issuedate<=?', issuedate2]).map(&:stationery_id).uniq.count!=0
    0.upto(StationeryUse.find(:all,:conditions=>['issuedate<=?', issuedate2]).map(&:stationery_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a if exist > 0 && issuedate2.blank? == false
  end
  def issuedate2_conditions  
    ["( "+issuedate2_details+")", StationeryUse.find(:all,:conditions=>['issuedate<=?', issuedate2]).map(&:stationery_id).uniq] if (StationeryUse.find(:all,:conditions=>['issuedate<=?', issuedate2]).count) > 0 && issuedate2.blank? == false 
  end
  
  
#   def received_conditions
#     ["received>=?", received] unless received.blank?
#   end
#   def received2_conditions  #between 2 dates
#     ["received<=?", received2] unless received2.blank?
#   end
  
  def issuedby_details
    exist = StationeryUse.find(:all,:conditions=>['issuedby=?', issuedby]).count
    a='id=? ' if StationeryUse.find(:all,:conditions=>['issuedby=?', issuedby]).map(&:stationery_id).uniq.count!=0
    0.upto(StationeryUse.find(:all,:conditions=>['issuedby=?', issuedby]).map(&:stationery_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a if exist > 0 && issuedby.blank? == false
  end
  def issuedby_conditions  
    ["( "+issuedby_details+")",StationeryUse.find(:all,:conditions=>['issuedby=?', issuedby]).map(&:stationery_id).uniq] if (StationeryUse.find(:all,:conditions=>['issuedby=?', issuedby]).count) > 0 && issuedby.blank? == false 
  end
  
  def receivedby_details
    exist = StationeryUse.find(:all,:conditions=>['receivedby=?', receivedby]).count
    a='id=? ' if StationeryUse.find(:all,:conditions=>['receivedby=?', receivedby]).map(&:stationery_id).uniq.count!=0
    0.upto(StationeryUse.find(:all,:conditions=>['receivedby=?', receivedby]).map(&:stationery_id).uniq.count-2) do |l|  
      a=a+'OR id=? '
    end 
    return a if exist > 0 && receivedby.blank? == false
  end
  def receivedby_conditions  
    ["( "+receivedby_details+")", StationeryUse.find(:all,:conditions=>['receivedby=?', receivedby]).map(&:stationery_id).uniq] if (StationeryUse.find(:all,:conditions=>['receivedby=?', receivedby]).count) > 0 && receivedby.blank? == false 
  end
  
  ################
  
  def orders
    "code ASC"# "staffgrade_id ASC"
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