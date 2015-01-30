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
        [ I18n.t('claim.transport'),   00 ],
        [ I18n.t('claim.taxi'),      11 ],
        [ I18n.t('claim.bus'),        12 ],
        [ I18n.t('claim.train'),   13 ],
        [ I18n.t('claim.ferry') ,       14 ],
        [ I18n.t('claim.plane'),15 ],
        [ "---------------",19 ],
        
        [ I18n.t('claim.misc'),   40 ],
        [ I18n.t('claim.toll'),        41 ],
        [ I18n.t('claim.parking'),42 ],
        [ I18n.t('claim.laundry'),       43 ],
        [ I18n.t('claim.post'),        44 ],
        [ I18n.t('claim.phone_telex_fax'),45 ],
        [ I18n.t('claim.exchanged'),   99 ]
  ]
  
  ALLOWANCETYPE = [
        #  Displayed       stored in db
        [ I18n.t('claim.meal_allowance'),21 ],
        [ I18n.t('claim.meal_allowance_ss'),22 ],
        [ I18n.t('claim.daily_allowance'),23 ],
        [ I18n.t('claim.lodging_allowance'),31 ],
        [ I18n.t('claim.hotel_rent'),32 ],
        [ I18n.t('claim.government_tax'),33 ]
  ]
  
end
