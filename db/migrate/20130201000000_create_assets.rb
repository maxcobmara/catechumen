class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string   :assetcode
      t.string   :cardno
      t.integer  :assettype
      t.boolean  :bookable
      t.string   :name
      t.string   :typename
      t.integer  :manufacturer_id
      t.string   :modelname
      t.string   :serialno
      t.text     :otherinfo
      t.string   :orderno
      t.decimal  :purchaseprice
      t.date     :purchasedate
      t.date     :receiveddate
      t.integer  :receiver_id
      t.integer  :supplier_id
      t.integer  :assignedto_id
      t.boolean  :locassigned
      t.integer  :status
      t.integer  :location_id
      t.integer  :country_id
      t.integer  :warranty_length
      t.integer  :warranty_length_type
      t.integer  :category_id
      t.string   :subcategory
      t.integer  :quantity
      t.string   :quantity_type
      t.integer  :engine_type_id
      t.string   :engine_no
      t.string   :registration
      t.string   :nationcode
      t.boolean  :mark_disposal
      t.boolean  :mark_as_lost
      t.boolean  :is_disposed
      t.boolean  :is_maintainable
      t.timestamps
    end

    create_table :maints do |t|
      t.integer  :asset_id
      t.integer  :maintainer_id
      t.string   :workorderno
      t.decimal  :maintcost
      t.text     :details
      t.timestamps
    end
    
    create_table :parts do |t|
      t.string   :partcode
      t.string   :category
      t.string   :unittype
      t.decimal  :quantity
      t.decimal  :maxquantity
      t.decimal  :minquantity
      t.timestamps
    end
    
    create_table :rxparts do |t|
      t.integer  :part_id
      t.string   :lponum
      t.string   :donum
      t.decimal  :quantity
      t.decimal  :unitcost
      t.decimal  :totalcost
      t.date     :rdate
      t.timestamps
    end
     
    create_table :asset_placements do |t|
      t.integer  :asset_id
      t.integer  :location_id
      t.integer  :staff_id
      t.date     :reg_on
      t.integer  :quantity
      t.timestamps
    end
    
    create_table :assetcategories do |t|
      t.integer  :parent_id
      t.string   :description
      t.integer  :cattype_id
      t.timestamps
    end
    
    create_table :assetnums do |t|
      t.integer  :asset_id
      t.string   :assetnumname
      t.string   :assetadnum
      t.timestamps
    end
    
    create_table :assetsearches do |t|
      t.string   :assetcode
      t.integer  :assettype
      t.string   :name
      t.decimal  :purchaseprice
      t.date     :purchasedate
      t.date     :startdate
      t.date     :enddate
      t.integer  :category
      t.integer  :assignedto
      t.boolean  :bookable
      t.date     :loandate
      t.date     :returndate
      t.integer  :location
      t.integer  :defect_asset
      t.integer  :defect_reporter
      t.integer  :defect_processor
      t.string   :defect_process
      t.boolean  :maintainable
      t.string   :maintname
      t.string   :maintcode
      t.integer  :disposal
      t.string   :disposaltype
      t.string   :discardoption
      t.string   :disposalreport
      t.integer  :disposalcert
      t.string   :disposalreport2
      t.integer  :loss_start
      t.integer  :loss_end
      t.integer  :loss_cert
      t.integer  :loanedasset
      t.integer  :alldefectasset
      t.decimal  :purchaseprice2
      t.date     :purchasedate2
      t.date     :receiveddate
      t.date     :receiveddate2
      t.date     :loandate2
      t.date     :returndate2
      t.date     :expectedreturndate
      t.date     :expectedreturndate2
      t.timestamps
    end
  end
  
  def self.down
  end
end

 