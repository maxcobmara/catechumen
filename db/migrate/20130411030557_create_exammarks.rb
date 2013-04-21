class CreateExammarks < ActiveRecord::Migration
  def self.up
    create_table :exammarks do |t|
      t.integer :student_id
      t.integer :exam_id

      t.timestamps
    end
  end

  def self.down
    drop_table :exammarks
  end
end
