class CreateSktTargets < ActiveRecord::Migration
  def self.up
    create_table :skt_targets do |t|
      t.integer :skt_staff_id
      t.string  :activity
      t.integer :status
      t.integer :approved
      t.timestamps
    end
  end

  def self.down
    drop_table :skt_targets
  end
end
