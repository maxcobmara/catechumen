class CreateLocations < ActiveRecord::Migration
  def self.up   
    create_table :locations do |t|
      t.string   :code
      t.string   :name
      t.integer  :lclass
      t.integer  :typename
      t.boolean  :allocatable
      t.boolean  :occupied
      t.integer  :staffadmin_id
      t.string   :ancestry
      t.timestamps
    end
    
    create_table :residences do |t|
      t.string   :rescode
      t.string   :resname
      t.integer  :parent_id
      t.integer  :resclass
      t.integer  :restype
      t.boolean  :allocatable
      t.integer  :staff_id
      t.integer  :student_id
      t.date     :keytxdt
      t.date     :keyreturndt
      t.date     :keyexpectdate
      t.boolean  :keyrx
      t.integer  :staffadmin_id
      t.string   :ancestry
      t.timestamps
    end
    add_index :residences, [:ancestry], :name => "index_residences_on_ancestry"
    
    create_table :tenants do |t|
      t.integer  :location_id
      t.integer  :staff_id
      t.integer  :student_id
      t.date     :keyaccept
      t.date     :keyexpectedreturn
      t.date     :keyreturned
      t.boolean  :force_vacate
      t.timestamps
    end
  end
  
  def self.down
  end
end