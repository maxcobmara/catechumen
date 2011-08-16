class AddSemesterToSubject < ActiveRecord::Migration
  def self.up
    add_column :subjects, :semester, :integer
  end

  def self.down
    remove_column :subjects, :semester
  end
end
