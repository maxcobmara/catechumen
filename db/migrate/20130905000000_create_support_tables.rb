class CreateSupportTables < ActiveRecord::Migration
  def self.up       
    create_table :titles do |t|
      t.string   :titlecode
      t.string   :name
      t.boolean  :berhormat
      t.timestamps
    end
    
    create_table :banks do |t|
      t.string   :short_name
      t.string   :long_name
      t.datetime :created_at
      t.datetime :updated_at
      t.boolean  :active
    end
  end
  
  def self.down
    drop_table :titles
    drop_table :banks
  end
end

 