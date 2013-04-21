class CreateAssetDefects < ActiveRecord::Migration
  def self.up
    create_table :asset_defects do |t|
      t.integer :asset_id
      t.integer :reported_by
      t.text    :notes
      t.text :description
      t.string :process_type
      t.text :recommendation
      t.boolean :is_processed
      t.integer :processed_by
      t.date :processed_on
      t.boolean :decision
      t.integer :decision_by
      t.date :decision_on

      t.timestamps
    end
  end

  def self.down
    drop_table :asset_defects
  end
end
