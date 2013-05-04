class Leaveforstaffs < ActiveRecord::Migration
  def self.up
    create_table :leaveforstaffs do |t|
          t.integer :staff_id
          t.integer :leavetype
          t.date :leavestartdate
          t.date :leavenddate
          t.decimal :leavedays
          t.string :reason
          t.text :notes
          t.integer :replacement_id
          t.boolean :submit
          t.boolean :approval1
          t.integer :approval1_id
          t.date :approval1date
          t.boolean :approver2
          t.integer :approval2_id
          t.date :approval2date

          t.timestamps
        end
    
  end

  def self.down
       drop_table :leaveforstaffs
  end
end
