class CreateStaffcourses < ActiveRecord::Migration
  def self.up
    create_table :staffcourses do |t|
      t.string  :name
      t.integer :coursetype
      t.string  :provider
      t.string  :location
      t.decimal :duration, :precision => 4, :scale => 1, :default => 0
      t.integer :duration_type
      t.string  :proponent
      t.decimal :cost, :precision => 8, :scale => 2, :default => 2
      t.date    :course_date

      t.timestamps
    end
  end

  def self.down
    drop_table :staffcourses
  end
end
