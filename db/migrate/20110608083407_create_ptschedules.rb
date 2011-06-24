class CreatePtschedules < ActiveRecord::Migration
  def self.up
    create_table :ptschedules do |t|
      t.integer   :ptcourse_id
      t.date      :start
      t.string    :location
      t.integer   :min_participants
      t.integer   :max_participants
      t.decimal   :final_price
      t.boolean   :budget_ok

      t.timestamps
    end
  end

  def self.down
    drop_table :ptschedules
  end
end
