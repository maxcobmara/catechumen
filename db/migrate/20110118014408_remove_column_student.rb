class RemoveColumnStudent < ActiveRecord::Migration
  def self.up
     remove_column :students, :session
     remove_column :students, :sesyear
     remove_column :students, :sclass
   end

   def self.down
     add_column :staffs, :session, :integer
     add_column :staffs, :sesyear, :date
     add_column :staffs, :sclass, :string
   end
end
