class FixSubjectAverageLecturer < ActiveRecord::Migration
  def self.up
    remove_column :average_lecturers, :lesson_topic
    add_column  :average_lecturers, :subject_id, :integer
    
  end

  def self.down
    remove_column :average_lecturers, :subject_id
    add_column  :average_lecturers, :lesson_topic, :integer
  end
end
