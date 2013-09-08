class CreateEvaluatecoursesearches < ActiveRecord::Migration
  def self.up
    create_table :evaluatecoursesearches do |t|
      t.integer :programme_id
      t.integer :subject_id
      t.date :evaldate
      t.integer :lecturer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :evaluatecoursesearches
  end
end