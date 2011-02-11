class Part < ActiveRecord::Base
  has_many :assetloss, :foreign_key => 'part_id'
  
   belongs_to :asset, :foreign_key => 'asset_id' 
   
    def self.find_main
      Asset.find(:all, :condition => ['asset_id IS NULL'])
    end
    
 
#--------- code for repeating field receiver---------------------
   has_many :rxparts, :dependent => :destroy

    def new_rxpart_attributes=(rxpart_attributes)
      rxpart_attributes.each do |attributes|
        rxparts.build(attributes)
      end
    end

    after_update :save_rxparts

    def existing_rxpart_attributes=(rxpart_attributes)
      rxparts.reject(&:new_record?).each do |rxpart|
        attributes = rxpart_attributes[rxpart.id.to_s]
        if attributes
          rxpart.attributes = attributes
        else
          rxparts.delete(rxpart)
        end
      end
    end

    def save_rxparts
      rxparts.each do |rxpart|
        rxpart.save(false)
      end
    end
#------------------------------------------------------------------------    
#--------------- code for repeating issue receiver-----------------------
       has_many :txsupplieses, :dependent => :destroy

       def new_txsupplies_attributes=(txsupplies_attributes)
         txsupplieses_attributes.each do |attributes|
           txsupplieses.build(attributes)
         end
       end

       after_update :save_txsupplieses

       def existing_txsupplies_attributes=(txsupplies_attributes)
         txsupplieses.reject(&:new_record?).each do |txsupplies|
           attributes = txsupplies_attributes[txsupplies.id.to_s]
           if attributes
             txsupplies.attributes = attributes
           else
             txsupplieses.delete(txsupplies)
           end
         end
       end

       def save_txsupplieses
        txsupplieses.each do |txsupplies|
           txsupplieses.save(false)
         end
       end
#------------------------------------------------------------------------
#-----------------------Code for Addsupplies-----------------------------

end