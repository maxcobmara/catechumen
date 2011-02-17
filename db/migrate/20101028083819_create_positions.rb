class CreatePositions < ActiveRecord::Migration
  def self.up
    create_table :positions do |t|
      t.string    :positioncode
      t.string    :positionname
      t.integer   :parent_id 
      t.string    :unit
      t.text      :taskmain
      t.text      :taskother
      t.integer   :staffgrade_id

      t.timestamps
    end
  end

  def self.down
    drop_table :positions
  end
end
