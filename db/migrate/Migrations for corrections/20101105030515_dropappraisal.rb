class Dropappraisal < ActiveRecord::Migration
  def self.up
    drop_table :appraisals
  end

  def self.down
     create_table :appraisals do |t|	
          t.string   :appraisal
          t.integer  :staff_id	
    	
          t.timestamps
        end
  end
end
