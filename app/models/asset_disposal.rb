class AssetDisposal < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  
  belongs_to :asset
  belongs_to :processor, :class_name => 'Staff', :foreign_key => 'checked_by'
  belongs_to :verifier,  :class_name => 'Staff', :foreign_key => 'verified_by'
  belongs_to :revaluer,  :class_name => 'Staff', :foreign_key => 'revalued_by'
  belongs_to :disposer,  :class_name => 'Staff', :foreign_key => 'disposed_by'
  belongs_to :discardw1tness,  :class_name => 'Staff', :foreign_key => 'discard_witness_1'
  belongs_to :discardw2tness,  :class_name => 'Staff', :foreign_key => 'discard_witness_2'
  
  belongs_to :document
  
  
  def age
    Date.today - @asset.purchasedate
  end
  
  def disposal_status
    if is_checked == false
      "Processing"
    elsif is_checked == true && is_verified != true
      "Processed"
    elsif is_verified == true && is_disposed != true
      "Verified"
    elsif is_disposed == true && is_discarded != true
      "Disposed"
    elsif is_discarded == true
      "Discarded"
    else
      "Unknown"
    end
  end
  
  def disposal_malay
    if disposal_type == "transfer"
        "Pindahan/hadiah"
    elsif disposal_type == "discard"
        "Musnah"
    elsif disposal_type == "sold"
        "Jualan"
    elsif disposal_type == "stock"
        "Stok"
    else
        "Lain-lain"
    end
    
  end
  
  def discard_malay
    if discard_options == "bury"
      "Tanam"
    elsif discard_options == "burn"
      "Bakar"
    elsif discard_options == "throw"
      "Buang"
    elsif discard_options == "sink"
      "Tenggelam"
    else
      ""
    end
  end
  
  def secara_malay
    if discard_options == "bury"
      " Tanam <del>/ Bakar / Buang / Tenggelam </del> "
    elsif discard_options == "burn"
      " <del>Tanam / </del> Bakar <del>/ Buang / Tenggelam </del> "
    elsif discard_options == "throw"
      " <del>Tanam /  Bakar /</del> Buang / <del> Tenggelam </del> "
    elsif discard_options == "sink"
      " <del>Tanam /  Bakar / Buang / </del> Tenggelam "
    else
      " Tanam /  Bakar / Buang / Tenggelam "
    end
  end
      
  def complete_for_report
    "#{asset.code_asset}"+" ("+"#{disposal_type.upcase}"+" on "+"#{disposed_on.strftime('%d-%b-%Y')}"+")"
    
  end    
end
