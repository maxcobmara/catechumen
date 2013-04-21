class RemoveColumnFromExamresult < ActiveRecord::Migration
  def self.up
    remove_column :examresults, :total
    remove_column :examresults, :pngs17
    remove_column :examresults, :status
    remove_column :examresults, :remark
  end

  def self.down
    add_column :examresults, :total, :decimal
    add_column :examresults, :pngs17, :decimal
    add_column :examresults, :status, :string
    add_column :examresults, :remark, :string
  end
end
