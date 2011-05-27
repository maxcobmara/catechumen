class CreateEmploygrades < ActiveRecord::Migration
  def self.up
    create_table :employgrades do |t|
      t.string :name
      t.integer :group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :employgrades
  end
end
