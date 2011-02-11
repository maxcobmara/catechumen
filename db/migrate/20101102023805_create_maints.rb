class CreateMaints < ActiveRecord::Migration
  def self.up
    create_table :maints do |t|
      t.integer   :asset_id
      t.integer   :maintainer_id
      t.string    :workorderno
      t.decimal   :maintcost
      t.text      :details
      
      t.timestamps
    end
  end

  def self.down
    drop_table :maints
  end
end
