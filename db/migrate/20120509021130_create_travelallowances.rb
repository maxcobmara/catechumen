class CreateTravelallowances < ActiveRecord::Migration
  def self.up
    create_table :travelallowances do |t|
      t.integer :travelclaim_id
      t.integer :allowance_type
      t.decimal :allowance_per_day
      t.integer :no_of_day
      t.string  :resit_no
      t.decimal :sum_allowance
      t.timestamps
    end
  end

  def self.down
    drop_table :travelallowances
  end
end
