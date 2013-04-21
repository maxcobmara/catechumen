class CreateTimetables < ActiveRecord::Migration
  def self.up
    create_table :timetables do |t|
      t.string :code
      t.string :name
      t.string :description
      t.integer :created_by

      t.timestamps
    end
  end

  def self.down
    drop_table :timetables
  end
end
