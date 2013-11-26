class CreateStaffPositions < ActiveRecord::Migration
  def self.up   
    create_table :positions do |t|
      t.string   :code
      t.string   :combo_code
      t.string   :name
      t.string   :unit
      t.text     :tasks_main
      t.text     :tasks_other
      t.integer  :staffgrade_id
      t.integer  :staff_id
      t.boolean  :is_acting
      t.string   :ancestry
      t.integer  :ancestry_depth
      t.timestamps
    end
    
    create_table :staff_grades do |t|
      t.string   :name
      t.string   :grade
      t.integer  :level
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :classification_id
      t.string   :group_id
      t.string   :schemename
      t.timestamps
    end
    
    create_table :staffemploygrades do |t|
      t.integer  :staffemployscheme_id
      t.integer  :employgrade_id
      t.string   :name
      t.timestamps
    end

    create_table :staffemployschemes do |t|
      t.string   :glass
      t.string   :name
      t.timestamps
    end
  end
  
  def self.down
  end
end

 