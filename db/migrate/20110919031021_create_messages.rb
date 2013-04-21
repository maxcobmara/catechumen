class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :from_id
      t.integer :to_id
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
