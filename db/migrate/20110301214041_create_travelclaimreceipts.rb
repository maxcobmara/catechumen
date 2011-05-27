class CreateTravelclaimreceipts < ActiveRecord::Migration
  def self.up
    create_table :travelclaimreceipts do |t|
      t.integer :travelclaim_id
      t.integer :type_id
      t.string :receiptnp
      t.decimal :rvalue

      t.timestamps
    end
  end

  def self.down
    drop_table :travelclaimreceipts
  end
end
