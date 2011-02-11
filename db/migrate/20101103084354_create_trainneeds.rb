class CreateTrainneeds < ActiveRecord::Migration
  def self.up
    create_table :trainneeds do |t|
      t.integer :appraisal_id
      t.string :name
      t.string :reason
      t.string :confirmedby_id

      t.timestamps
    end
  end

  def self.down
    drop_table :trainneeds
  end
end
