class AddColumnsToLessonplansearch < ActiveRecord::Migration
  def self.up
    add_column :lessonplansearches, :intake, :integer
  end

  def self.down
    remove_column :lessonplansearches, :intake
  end
end
