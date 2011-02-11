class CreateAttendances < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.integer   :staff_id
      t.date      :attdate
      t.time      :time_in
      t.time      :time_out
      t.string    :reason
      t.integer   :approve_id
      t.boolean   :approvestatus

      t.timestamps
    end
  end

  def self.down
    drop_table :attendances
  end
end
