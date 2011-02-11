class CreateQualifications < ActiveRecord::Migration
  def self.up
      create_table :qualifications do |t|
        t.integer    :staff_id	
        t.integer    :student_id	
        t.integer    :level_id	
        t.string     :qname	
        t.integer    :institute_id
        t.string     :institute		
       
        t.timestamps
	
      end	
    end
  	
	
    def self.down	
      drop_table :qualifications	
    end
end
