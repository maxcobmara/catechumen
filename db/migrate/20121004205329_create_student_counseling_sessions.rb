class CreateStudentCounselingSessions < ActiveRecord::Migration
  def self.up
    create_table :student_counseling_sessions do |t|
      t.integer   :student_id
      t.integer   :case_id
      t.datetime  :requested_at
      t.text      :alt_dates
      t.string    :c_type
      t.string    :c_scope
      t.integer   :duration
      t.boolean   :is_confirmed
      t.datetime  :confirmed_at
      t.text      :issue_desc
      t.text      :notes
      t.integer   :file_id
      t.text      :suggestions
      t.integer   :staff_id
      t.integer   :created_by
      t.string    :created_by_type
      t.integer   :confirmed_by
      t.string    :confirmed_by_type

      t.timestamps
    end
  end

  def self.down
    drop_table :student_counseling_sessions
  end
end
