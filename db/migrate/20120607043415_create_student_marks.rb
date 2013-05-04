class CreateStudentMarks < ActiveRecord::Migration
  def self.up
    create_table :student_marks do |t|
      t.integer :analysis_grade_id
      t.integer :student_id
      t.integer :m_1
      t.integer :m_2
      t.integer :m_3
      t.integer :m_4
      t.integer :m_5
      t.integer :m_6
      t.integer :m_7
      t.integer :m_8
      t.integer :m_9
      t.integer :m_10
      
      t.integer :m_11
      t.integer :m_12
      t.integer :m_13
      t.integer :m_14
      t.integer :m_15
      t.integer :m_16
      t.integer :m_17
      t.integer :m_18
      t.integer :m_19
      t.integer :m_20
      
      t.integer :m_21
      t.integer :m_22
      t.integer :m_23
      t.integer :m_24
      t.integer :m_25
      t.integer :m_26
      t.integer :m_27
      t.integer :m_28
      t.integer :m_29
      t.integer :m_30
      
      t.integer :m_31
      t.integer :m_32
      t.integer :m_33
      t.integer :m_34
      t.integer :m_35
      t.integer :m_36
      t.integer :m_37
      t.integer :m_38
      
      t.integer :total_mark
      
      t.timestamps
    end
  end

  def self.down
    drop_table :student_marks
  end
end
