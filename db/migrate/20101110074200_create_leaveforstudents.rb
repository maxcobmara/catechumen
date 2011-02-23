class CreateLeaveforstudents < ActiveRecord::Migration
  def self.up
    create_table :leaveforstudents do |t|
      t.integer :student_id
      t.string  :leavetype
      t.date    :requestdate
      t.string  :reason
      t.string  :address
      t.string  :telno
      t.date    :leave_startdate
      t.date    :leave_enddate
      t.text    :notes
      t.boolean :studentsubmit
      t.boolean :approved
      t.integer :staff_id
      t.date    :approvedate
      

      t.timestamps
    end
  end

  def self.down
    drop_table :leaveforstudents
  end
end
