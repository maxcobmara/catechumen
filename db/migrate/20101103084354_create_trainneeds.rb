class CreateTrainneeds < ActiveRecord::Migration
  def self.up
    create_table :trainneeds do |t|
      t.integer :evaluation_id
      t.string  :name
      t.string  :reason
      t.integer :confirmedby_id

      t.timestamps
    end
  end

  def self.down
    drop_table :trainneeds
  end
end
