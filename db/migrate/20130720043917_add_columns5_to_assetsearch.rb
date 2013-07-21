class AddColumns5ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :defect_process, :string
    add_column :assetsearches, :maintainable, :boolean
  end

  def self.down
    remove_column :assetsearches, :maintainable
    remove_column :assetsearches, :defect_process
  end
end
