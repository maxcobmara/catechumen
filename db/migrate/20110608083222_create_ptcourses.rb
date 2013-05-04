class CreatePtcourses < ActiveRecord::Migration
  def self.up
    create_table :ptcourses do |t|
      t.string  :name
      t.integer :course_type
      t.integer :provider
      t.decimal :duration
      t.integer :duration_type
      t.string  :proponent
      t.decimal :cost
      t.text    :description
      t.boolean :approved

      t.timestamps
    end
  end

  def self.down
    drop_table :ptcourses
  end
end
