class TravelClaimLog < ActiveRecord::Base
  belongs_to :travel_request
  
  validates_numericality_of :mileage,  :unless => proc{|obj| obj.mileage.blank?}
  validates_numericality_of :km_money, :unless => proc{|obj| obj.km_money.blank?}


  validate :mileage_xor_km_money

    private

      def mileage_xor_km_money
        if !(mileage.blank? ^ km_money.blank?)
          errors.add_to_base(I18n.t('claim.mileage_xor_km_money'))
        end
      end
  
end
