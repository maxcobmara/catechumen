class AddColumn2ToExamtemplate < ActiveRecord::Migration
  def self.up
    add_column :examtemplates, :total_marks, :decimal
  end

  def self.down
    remove_column :examtemplates, :total_marks
  end
end
