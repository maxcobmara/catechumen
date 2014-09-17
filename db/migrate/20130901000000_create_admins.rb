class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :login,                     :limit => 40
      t.string   :name,                      :limit => 100, :default => ""
      t.string   :email,                     :limit => 100
      t.string   :crypted_password,          :limit => 40
      t.string   :salt,                      :limit => 40
      t.string   :remember_token,            :limit => 40
      t.datetime :remember_token_expires_at
      t.integer  :staff_id
      t.integer  :student_id
      t.boolean  :isstaff
      t.string   :icno
      t.timestamps
    end

    add_index :users, [:login], :name => "index_logins_on_login", :unique => true
    
    create_table :roles do |t|
      t.string   :name
      t.string   :authname
      t.timestamps
    end

    create_table :roles_logins, :id => false do |t|
      t.integer :role_id
      t.integer :login_id
    end
    
    create_table :pages do |t|
      t.string   :name
      t.string   :title
      t.text     :body
      t.boolean  :admin
      t.integer  :parent_id
      t.string   :navlabel
      t.integer  :position
      t.boolean  :redirect
      t.string   :action_name
      t.string   :controller_name
      t.timestamps
    end
  end
  
  def self.down
  end
end