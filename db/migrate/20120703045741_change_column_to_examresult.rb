class ChangeColumnToExamresult < ActiveRecord::Migration
  def self.up
    remove_column :examresults, :semester
    add_column    :examresults, :semester, :string
  end

  def self.down
    remove_column :examresults, :semester
    add_column    :examresults, :semester, :integer
  end
end
