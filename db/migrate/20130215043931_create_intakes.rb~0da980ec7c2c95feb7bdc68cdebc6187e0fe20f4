class CreateIntakes < ActiveRecord::Migration
  def self.up
    create_table :intakes do |t|
      t.string :name
      t.string :description
      t.date :register_on
      t.integer :programme_id
      t.boolean :is_active

      t.timestamps
    end
  end

  def self.down
    drop_table :intakes
  end
end
