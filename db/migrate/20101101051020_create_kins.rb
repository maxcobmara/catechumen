class CreateKins < ActiveRecord::Migration
  def self.up
    create_table :kins do |t|

      t.integer :kintype_id
      t.integer :staff_id
      t.integer :student_id
      t.string  :name
      t.date    :kinbirthdt
      t.string  :phone
      t.string  :kinaddr
      t.timestamps
    end
  end

  def self.down
    drop_table :kins
  end
end
