class Addcolumnsubject < ActiveRecord::Migration
  def self.up
    add_column :exammakers, :subject_id, :integer
  end

  def self.down
    remove_column :exammakers, :subject_id
  end
end
