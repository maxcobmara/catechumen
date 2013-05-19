class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string  :id_no1
      t.string  :id_no2
      t.string  :name
      t.string  :email
      t.string  :telephone
      t.string  :gender,              :limit => 10
      t.date    :born_on
      t.date    :registered_on
      t.text    :address
      t.boolean :status_type
      t.string  :marital_status,      :limit => 10
      t.integer :sponsor_id
      t.integer :intake_id,           :null => false, :default => ""
      t.integer :programme_id,        :null => false, :default => ""
      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.integer :account_id,          :null => false, :default => ""

      t.timestamps
    end
     add_index :students, :id_no1,  :unique => true
     add_index :students, :id_no2,  :unique => true
     add_index :students, :name,    :unique => true
  end
end
