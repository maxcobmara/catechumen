class CreateRxparts < ActiveRecord::Migration
  def self.up
    create_table :rxparts do |t|
      
      t.integer :part_id
      t.string :lponum
      t.string :donum
      t.decimal :quantity
      t.decimal :unitcost
      t.decimal :totalcost
      t.date :rdate

      t.timestamps
    end
  end

  def self.down
    drop_table :rxparts
  end
end
