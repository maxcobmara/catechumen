class CreateLessonplansearches < ActiveRecord::Migration
  def self.up
    create_table :lessonplansearches do |t|
      t.integer :lecturer
      t.integer :intake_id
      t.integer :programme_id
      t.timestamps
    end
  end

  def self.down
    drop_table :lessonplansearches
  end
end
