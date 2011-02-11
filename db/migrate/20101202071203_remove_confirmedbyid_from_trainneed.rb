class RemoveConfirmedbyidFromTrainneed < ActiveRecord::Migration
  def self.up
    remove_column :trainneeds, :confirmedby_id
  end

  def self.down
    add_column :trainneeds, :confirmedby_id, :string
  end
end
