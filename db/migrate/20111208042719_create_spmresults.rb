class CreateSpmresults < ActiveRecord::Migration
  def self.up
      create_table :spmresults do |t|
        t.integer :student_id
        t.string :spm_subject
        t.integer :spmsubject_id
        t.string :grade

        t.timestamps
      end
    end

    def self.down
      drop_table :spmresults
    end
end
