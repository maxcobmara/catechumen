class DropCurriculumAndCurruculumjoin < ActiveRecord::Migration
  def self.up
     drop_table :curriculums
     drop_table :asset_curriculums
   end

   def self.down
      create_table :curriculums do |t|	
           t.string   :justforshow
           t.timestamps
      end
      create_table :asset_curriculums do |t|	
           t.string   :justforshow
           t.timestamps
      end
   end
end
