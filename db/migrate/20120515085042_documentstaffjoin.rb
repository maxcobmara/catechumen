class Documentstaffjoin < ActiveRecord::Migration
  def self.up
      create_table :documents_staffs, :id => false do |t|
        t.integer :document_id
        t.integer :staff_id
      end 
    end

   def self.down
     drop_table :documents_staffs
   end
end
