class CreateMarks < ActiveRecord::Migration
  def self.up
    create_table :marks do |t|
      t.integer :exammark_id
      t.decimal :student_mark

      t.timestamps
    end
  end

  def self.down
    drop_table :marks
  end
end
