class CreateTitles < ActiveRecord::Migration
  def self.up
    create_table :titles do |t|
      t.string :titlecode
      t.string :name
      t.boolean :berhormat

      t.timestamps
    end
  end

  def self.down
    drop_table :titles
  end
end
