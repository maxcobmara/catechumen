class CreateExamresults < ActiveRecord::Migration
   def self.up
      create_table :examresults do |t|
        t.integer :semester
        t.integer :programme_id
        t.decimal :total
        t.decimal :pngs17
        t.string :status
        t.string :remark

        t.timestamps
      end
    end

    def self.down
      drop_table :examresults
    end
end