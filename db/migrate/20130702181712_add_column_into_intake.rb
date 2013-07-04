class AddColumnIntoIntake < ActiveRecord::Migration
  def self.up
     add_column :intakes, :monthyear_intake, :date
   end

   def self.down
     remove_column :intakes, :monthyear_intake
   end
end
