class Addcolumnstudentmark < ActiveRecord::Migration
  def self.up
    
    #addcolumn student mark
    add_column :student_marks, :m_39, :integer
    add_column :student_marks, :m_40, :integer
    add_column :student_marks, :m_41, :integer
    add_column :student_marks, :m_42, :integer
    add_column :student_marks, :m_43, :integer
    add_column :student_marks, :m_44, :integer
    add_column :student_marks, :m_45, :integer
    add_column :student_marks, :m_46, :integer
    add_column :student_marks, :m_47, :integer
    add_column :student_marks, :m_48, :integer
    add_column :student_marks, :m_49, :integer
    add_column :student_marks, :m_50, :integer
    
  end

  def self.down
    #addcolumn student mark
    remove_column :student_marks, :m_39
    remove_column :student_marks, :m_40
    remove_column :student_marks, :m_41
    remove_column :student_marks, :m_42
    remove_column :student_marks, :m_43
    remove_column :student_marks, :m_44
    remove_column :student_marks, :m_45
    remove_column :student_marks, :m_46
    remove_column :student_marks, :m_47
    remove_column :student_marks, :m_48
    remove_column :student_marks, :m_49
    remove_column :student_marks, :m_50
    
   
  end
end
