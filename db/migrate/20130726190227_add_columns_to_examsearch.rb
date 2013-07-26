class AddColumnsToExamsearch < ActiveRecord::Migration
  def self.up
    add_column :examsearches, :examtype, :string
    add_column :examsearches, :created_by, :integer
    add_column :examsearches, :klass_id, :integer
    add_column :examsearches, :examdate, :date
  end

  def self.down
    remove_column :examsearches, :examdate
    remove_column :examsearches, :klass_id
    remove_column :examsearches, :created_by
    remove_column :examsearches, :examtype
  end
end
