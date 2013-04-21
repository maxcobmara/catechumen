class AddGradeIdColumnIntoScore < ActiveRecord::Migration
  def self.up
    add_column :scores, :grade_id, :integer
  end

  def self.down
    remove_column :scores, :grade_id
  end
end
