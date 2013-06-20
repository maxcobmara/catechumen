class CreateExamtemplates < ActiveRecord::Migration
  def self.up
    create_table :examtemplates do |t|
      t.integer :questiontype
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :examtemplates
  end
end
