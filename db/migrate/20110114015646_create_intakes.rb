class CreateIntakes < ActiveRecord::Migration
  def self.up
    create_table :intakes do |t|
      t.string  :name
      t.integer :intake_no
      t.date    :year
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :intakes
  end
end
