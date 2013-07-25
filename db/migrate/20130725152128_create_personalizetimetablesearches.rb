class CreatePersonalizetimetablesearches < ActiveRecord::Migration
  def self.up
    create_table :personalizetimetablesearches do |t|
      t.integer :lecturer
      t.integer :programme_id
      t.timestamps
    end
  end

  def self.down
    drop_table :personalizetimetablesearches
  end
end
