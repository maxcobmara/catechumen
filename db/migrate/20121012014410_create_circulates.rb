class CreateCirculates < ActiveRecord::Migration
  def self.up
    create_table :circulates do |t|
       t.integer :document_id
        t.integer :cc_staff
        t.integer :action_cc
        t.string  :cc_staff
      t.timestamps
    end
  end

  def self.down
    drop_table :circulates
  end
end
