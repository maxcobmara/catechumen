class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer   :eventname
      t.integer   :location
      t.string    :participants
      t.decimal   :officiated
      t.datetime  :start_at
      t.datetime  :end_at
      t.integer   :created_by
      t.boolean   :event_is_publik

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
