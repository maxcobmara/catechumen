class AddDeliveryqualityAverageLecturer < ActiveRecord::Migration
  def self.up
    add_column :average_lecturers, :delivery_quality, :integer #last time-lesson_topic
  end

  def self.down
    remove_column :average_lecturers, :delivery_quality
  end
end
