class TravelClaimReceipt < ActiveRecord::Base
  belongs_to :travel_claim
  
  def exchange_loss
    amount * 0.03
  end
  
  def exchange_loss_wrong
    exchanged = travel_claim_receipts.sum(:amount, :conditions => ["expenditure_type = ?", 99 ])
    number_with_precision((exchanged * 0.03), :precision => 2)
  end
  
  
  RECEIPTTYPE = [
        #  Displayed       stored in db
        [ "Transport",   00 ],
        [ "- Teksi",      11 ],
        [ "- Bas",        12 ],
        [ "- Keretapi",   13 ],
        [ "- Feri",       14 ],
        [ "- Kapal Terbang",15 ],
        [ "---------------",19 ],
        
        [ "Miscellaneous",   40 ],
        [ "-  Tol",        41 ],
        [ "-  Tempat Letak Kereta",42 ],
        [ "-  Dobi",       43 ],
        [ "-  Pos",        44 ],
        [ "-  Telefon/Teleks/Fax",45 ],
        [ "-  Exchanged",   99 ]
  ]
  
  ALLOWANCETYPE = [
        #  Displayed       stored in db
        [ "Elaun Makan",21 ],
        [ "Elaun Makan (S/S)",22 ],
        [ "Elaun Harian",23 ],
        [ "Elaun Lodging",31 ],
        [ "Sewa Hotel",32 ],
        [ "Cukai Kerajaan",33 ]
  ]
  
  
  
end
