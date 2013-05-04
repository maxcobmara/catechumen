class CreateTrainingreports < ActiveRecord::Migration
  def self.up
    create_table :trainingreports do |t|
      t.integer :classtype
      t.integer :timetable_id
      t.boolean :location_state
      t.text :ls_comment
      t.text :staff_comment
      t.integer :staff_id
      t.boolean :submit
      t.text :tpa_comment
      t.integer :tpa_id
      t.timestamps
    end
  end

  def self.down
    drop_table :trainingreports
  end
end
