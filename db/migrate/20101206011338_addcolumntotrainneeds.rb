class Addcolumntotrainneeds < ActiveRecord::Migration
  def self.up
      add_column :trainneeds, :appraisal_id, :integer
  end

  def self.down
     remove_column :trainneeds, :appraisal_id
  end
end
