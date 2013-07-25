class CreateWeeklytimetablesearches < ActiveRecord::Migration
  def self.up
    create_table :weeklytimetablesearches do |t|
      t.integer :programme_id
      t.date :intake
      t.date :startdate
      t.date :enddate
      t.integer :preparedby
      t.timestamps
    end
  end

  def self.down
    drop_table :weeklytimetablesearches
  end
end
