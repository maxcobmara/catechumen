class CreateScsessions < ActiveRecord::Migration
  def self.up
    create_table :scsessions do |t|
      t.integer :counselling_id
      t.datetime :scsessiondt
      t.time :scsessiondtduration
      t.integer :scsappointnum
      t.string :scsessiontype
      t.string :issue
      t.text :suggestion
      t.text :remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :scsessions
  end
end
