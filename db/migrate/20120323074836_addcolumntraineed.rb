class Addcolumntraineed < ActiveRecord::Migration
  def self.up
    add_column :trainneeds, :appraosal_id, :integer
  end

  def self.down
    remove_column :trainneeds, :appraosal_id, :integer
  end
end
