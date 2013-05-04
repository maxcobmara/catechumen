class Fixcolumnmark < ActiveRecord::Migration
  def self.up
    rename_column :marks, :exammark_id,       :analysispaperexam_id
  end

  def self.down
    rename_column :marks, :analysispaperexam_id,       :exammark_id
  end
end
