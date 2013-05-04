class Stuattstudents < ActiveRecord::Migration
  def self.up
     add_column :studentattendances, :date_attendance, :date
     add_column :studentattendances, :topic_id, :integer
     remove_column :studentattendances_students, :attend
     remove_column :studentattendances_students, :reason
  end

  def self.down
    remove_column :studentattendances, :date_attendance
    add_column :studentattendances_students, :attend, :boolean
    add_column :studentattendances_students, :reason, :string
  end
end
