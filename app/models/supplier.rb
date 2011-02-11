class Supplier < ActiveRecord::Base
  
  def current_quantity
    a = Addsupplier.sum(:quantity, :conditions => ["supplier_id = ?", id])
    b = Usesupply.sum(:quantity, :conditions => ["supplier_id = ?", id])
    a - b
  end
  
  
  #-----Repeating fields-----------------------------------------------------------------------  
  # code for repeating field add supplies
    has_many :addsuppliers, :dependent => :destroy

    def new_addsupplier_attributes=(addsupplier_attributes)
      addsupplier_attributes.each do |attributes|
        addsuppliers.build(attributes)
      end
    end

    after_update :save_addsuppliers

    def existing_addsupplier_attributes=(addsupplier_attributes)
      addsuppliers.reject(&:new_record?).each do |addsupplier|
        attributes = addsupplier_attributes[addsupplier.id.to_s]
        if attributes
          addsupplier.attributes = attributes
        else
          addsuppliers.delete(addsupplier)
        end
      end
    end

    def save_addsuppliers
      addsuppliers.each do |addsupplier|
        addsupplier.save(false)
      end
    end
  #------------------------------------------------------------------------
  
  
  
  #-----Repeating fields-----------------------------------------------------------------------  
  # code for repeating field add supplies
    has_many :usesupplies, :dependent => :destroy

    def new_usesupply_attributes=(usesupply_attributes)
      usesupply_attributes.each do |attributes|
        usesupplies.build(attributes)
      end
    end

    after_update :save_usesupplies

    def existing_usesupply_attributes=(usesupply_attributes)
      usesupplies.reject(&:new_record?).each do |usesupply|
        attributes = usesupply_attributes[usesupply.id.to_s]
        if attributes
          usesupply.attributes = attributes
        else
          usesupplies.delete(addsupplier)
        end
      end
    end

    def save_usesupplies
      usesupplies.each do |usesupply|
        usesupply.save(false)
      end
    end
  #------------------------------------------------------------------------
  
 
end
