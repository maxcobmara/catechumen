class CreateTraveldetails < ActiveRecord::Migration
  def self.up
    create_table :traveldetails do |t|
      t.integer :travelclaimrequest_id
      t.date :travelday
      t.time :departure
      t.time :arrival
      t.text :description
      t.decimal :distance
      t.decimal :fare
      t.decimal :value
      t.boolean :lodging
      t.boolean :meals
      t.boolean :dinner

      t.timestamps
    end
  end

  def self.down
    drop_table :traveldetails
  end
end
