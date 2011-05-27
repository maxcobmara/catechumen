class FixThingsForClaims < ActiveRecord::Migration
  def self.up
    add_column    :travelclaims, :staff_id,    :integer
    add_column    :travelclaims, :claimsmonth, :date
    remove_column :travelclaims, :tstartdt
    remove_column :travelclaims, :treturndt
    remove_column :travelclaims, :distance
    remove_column :travelclaims, :distancevalue
    remove_column :travelclaims, :ifownwhy
    
    add_column    :travelrequests, :travelclaims_id, :integer
    remove_column :travelclaims,  :travelrequest_id
  end

  def self.down
  end
end