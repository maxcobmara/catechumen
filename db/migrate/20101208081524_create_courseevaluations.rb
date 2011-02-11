class CreateCourseevaluations < ActiveRecord::Migration
  def self.up
    create_table :courseevaluations do |t|
      t.integer :student_id
      t.integer :programme_id
      t.integer :subject_id

      t.timestamps
    end
  end

  def self.down
    drop_table :courseevaluations
  end
end
