class CreateExamresultsearches < ActiveRecord::Migration
  def self.up
    create_table :examresultsearches do |t|
      t.integer :programme_id
      t.integer :subject_id
      t.integer :student_id
      t.timestamps
    end
  end

  def self.down
    drop_table :examresultsearches
  end
end
