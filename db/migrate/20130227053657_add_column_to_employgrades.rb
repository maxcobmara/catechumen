class AddColumnToEmploygrades < ActiveRecord::Migration
  def self.up
    add_column :employgrades, :yearly_leave, :integer
  end

  def self.down
    remove_column :employgrades, :yearly_leave
  end
end
