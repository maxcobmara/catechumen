class CreateSktAchives < ActiveRecord::Migration
  def self.up
    create_table :skt_achives do |t|
      t.integer :skt_target_id
      t.integer :performance
      t.string :performance_detail
      t.string :target_work
      t.string :actual_achieve
      t.string :percent_achieve
      t.string :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :skt_achives
  end
end
