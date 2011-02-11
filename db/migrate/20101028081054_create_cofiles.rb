class CreateCofiles < ActiveRecord::Migration
  def self.up
    create_table :cofiles do |t|
      t.string :cofileno
      t.string :name
      t.string :location
      t.integer :owner_id
      t.boolean :onloan
      t.integer :staffloan_id
      t.date :onloandt
      t.date :onloanxdt

      t.timestamps
    end
  end

  def self.down
    drop_table :cofiles
  end
end
