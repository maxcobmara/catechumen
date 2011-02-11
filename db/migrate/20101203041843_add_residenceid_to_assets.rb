class AddResidenceidToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :residence_id, :integer
  end

  def self.down
    remove_column :assets, :residence_id
  end
end
