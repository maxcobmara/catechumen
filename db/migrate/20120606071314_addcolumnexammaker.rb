class Addcolumnexammaker < ActiveRecord::Migration
  def self.up
    add_column :exammakers, :course_id, :integer
    add_column :exammakers, :exam_date, :date
    add_column :exammakers, :duration_exam, :string
    add_column :exammakers, :full_mark, :integer
    add_column :exammakers, :pass_mark, :integer
    add_column :exammakers, :intake, :integer
    
  end

  def self.down
    remove_column :exammakers, :course_id
    remove_column :exammakers, :exam_date
    remove_column :exammakers, :duration_exam
    remove_column :exammakers, :full_mark
    remove_column :exammakers, :pass_mark
    remove_column :exammakers, :intake
  end
end
