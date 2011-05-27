class CreateTravelclaimrequests < ActiveRecord::Migration
  def self.up
    create_table :travelclaimrequests do |t|
      t.integer :travelclaim_id
      t.integer :travelrequest_id

      t.timestamps
    end
  end

  def self.down
    drop_table :travelclaimrequests
  end
end
