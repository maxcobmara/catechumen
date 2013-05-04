class CreateBanks < ActiveRecord::Migration
 def self.up
    create_table :banks do |t|
      t.string :short_name
      t.integer :long_name

      t.timestamps
    end
  end

  def self.down
    drop_table :banks
  end
end
