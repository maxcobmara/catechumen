class CreateResidences < ActiveRecord::Migration
  def self.up
    create_table :residences do |t|
      t.string :rescode
      t.string :resname
      t.integer :parent_id
      t.integer :resclass
      t.integer :restype
      t.boolean :allocatable
      t.integer :staff_id
      t.integer :student_id
      t.date :keytxdt
      t.date :keyreturndt
      t.date :keyexpectdate
      t.boolean :keyrx
      t.integer :staffadmin_id

      t.timestamps
    end
  end

  def self.down
    drop_table :residences
  end
end
