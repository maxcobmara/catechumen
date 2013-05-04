class Messagestaffjoin < ActiveRecord::Migration
  def self.up
      create_table :messages_staffs, :id => false do |t|
        t.integer :message_id
        t.integer :staff_id
      end 
    end

   def self.down
     drop_table :messages_staffs
   end
end
