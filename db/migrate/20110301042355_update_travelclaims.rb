class UpdateTravelclaims < ActiveRecord::Migration
  def self.up
    remove_column :travelrequests, :travelclaims_id
    add_column    :travelrequests, :travelclaims_id, :integer
  end

  def self.down
  end
end
