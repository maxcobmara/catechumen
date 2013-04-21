class CreateTrainingreports < ActiveRecord::Migration
  def self.up
    create_table :trainingreports do |t|
      t.integer :classtype
      t.integer :timetable_id
      t.boolean :location_state
      t.text    :location_comment #if location_state == false
      t.text    :abm_comment
      t.text    :summary
      t.integer :staff_id
      t.boolean :is_submitted
      t.date    :is_submitted_on
      t.integer :tpa_id
      t.text    :tpa_comment
      t.date    :tpa_comment_on

      t.timestamps
    end
  end

  def self.down
    drop_table :trainingreports
  end
end
