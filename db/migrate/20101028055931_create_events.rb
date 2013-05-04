class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :eventstdt
      t.datetime :eventendt
      t.string   :eventname
      t.string   :location
      t.text     :participants
      t.string   :officiated
      t.integer  :createdby
      t.boolean  :event_is_publik,

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
