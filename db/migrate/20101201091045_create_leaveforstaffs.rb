class CreateLeaveforstaffs < ActiveRecord::Migration
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
      t.boolean :approval1_idapproval1
      t.date :approval1date
      t.boolean :approver2_idapproval2
      t.date :approval2date

      t.timestamps
    end
  end

  def self.down
    drop_table :leaveforstaffs
  end
end
