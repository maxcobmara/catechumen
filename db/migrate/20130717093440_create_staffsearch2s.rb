class CreateStaffsearch2s < ActiveRecord::Migration
  def self.up
    create_table :staffsearch2s do |t|
      t.string :keywords
      t.integer :position
      t.integer :staff_grade
      t.timestamps
    end
  end

  def self.down
    drop_table :staffsearch2s
  end
end
