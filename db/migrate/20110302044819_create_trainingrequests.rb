class CreateTrainingrequests < ActiveRecord::Migration
  def self.up
    create_table :trainingrequests do |t|
      t.integer :staffcourse_id
      t.integer :staff_id
      t.integer :appraisal_id
      t.string :reason
      t.boolean :submit
      t.date :submitdate
      t.boolean :approved
      t.integer :approvedby_id
      t.date :approveddate

      t.timestamps
    end
  end

  def self.down
    drop_table :trainingrequests
  end
end
