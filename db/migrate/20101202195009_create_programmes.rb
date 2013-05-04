class CreateProgrammes < ActiveRecord::Migration
  def self.up
    create_table :programmes do |t|
      t.string :code
      t.string :name
      t.string :specialisation

      t.timestamps
    end
  end

  def self.down
    drop_table :programmes
  end
end
