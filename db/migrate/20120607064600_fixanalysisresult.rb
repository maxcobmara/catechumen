class Fixanalysisresult < ActiveRecord::Migration
  def self.up
    add_column :analysis_grades, :exam_paper_name, :integer
  end

  def self.down
    remove_column :analysis_grades, :exam_paper_name
  end
end
