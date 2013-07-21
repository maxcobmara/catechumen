class CreateStaffsearches < ActiveRecord::Migration
  def self.up
    create_table :staffsearches do |t|
      t.string :keywords
      t.integer :position
      t.integer :staff_grade

      t.timestamps
    end
  end

  def self.down
    drop_table :staffsearches
  end
end
