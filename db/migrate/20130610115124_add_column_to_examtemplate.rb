class AddColumnToExamtemplate < ActiveRecord::Migration
  def self.up
    add_column :examtemplates, :exam_id, :integer
  end

  def self.down
    remove_column :examtemplates, :exam_id
  end
end
