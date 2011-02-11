class CreateStrainings < ActiveRecord::Migration
  def self.up
    create_table :strainings do |t|
      t.integer :appraisal_id
      t.integer :staff_id
      t.string :name
      t.string :place
      t.date :sdate

      t.timestamps
    end
  end

  def self.down
    drop_table :strainings
  end
end
