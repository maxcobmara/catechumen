class FixColumnToExamtemplate < ActiveRecord::Migration
  def self.up
    remove_column :examtemplates, :questiontype
    add_column :examtemplates, :questiontype, :string
  end

  def self.down
    add_column :examtemplates, :questiontype, :integer
    remove_column :examtemplates, :questiontype
  end
end
