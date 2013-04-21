class CreateTrainings < ActiveRecord::Migration
  def self.up
    create_table :trainings do |t|
      t.string :code
      t.string :combo_code
      t.string :name
      t.string :course_type
      t.string :ancestry
      t.integer :ancestry_depth
      t.text :objective
      t.integer :duration
      t.integer :duration_type
      t.integer :credits
      t.integer :status
      t.index :ancestry

      t.timestamps
    end
  end

  def self.down
    drop_table :trainings
  end
end
