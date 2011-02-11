class AddConfirmedbyidToTrainneed < ActiveRecord::Migration
  def self.up
    add_column :trainneeds, :confirmedby_id, :integer
  end

  def self.down
    remove_column :trainneeds, :confirmedby_id
  end
end
