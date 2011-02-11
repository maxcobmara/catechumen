class DropColumnFromTrainneeds < ActiveRecord::Migration
  def self.up
     remove_column :trainneeds, :appraisal_id
  end

  def self.down
    add_column :trainneeds, :appraisal_id, :integer
  end
end
