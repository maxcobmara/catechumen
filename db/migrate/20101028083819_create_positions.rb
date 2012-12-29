class CreatePositions < ActiveRecord::Migration
  def self.up
    create_table :positions do |t|
      t.string    :code
      t.string    :combo_code
      t.string    :name
      t.string    :unit
      t.text      :tasks_main
      t.text      :tasks_other
      t.integer   :staffgrade_id
      t.integer   :staff_id
      t.boolean   :is_acting
      t.string    :ancestry
      t.integer   :ancestry_depth
      t.index :ancestry

      t.timestamps
    end
  end

  def self.down
    drop_table :positions
  end
end
