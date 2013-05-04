class CreateTrainingNotes < ActiveRecord::Migration
  def self.up
  	drop_table :trainingnotes
    create_table :training_notes do |t|
      t.integer :timetable_id
      t.string :title
      t.string :reference
      t.string :version
      t.string :staff_id
      t.date :release
      t.integer :topic_id
      t.timestamps
    end
  end

  def self.down
    drop_table :training_notes
  end
end
