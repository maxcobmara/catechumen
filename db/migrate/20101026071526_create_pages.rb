class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string   :name
      t.string   :title
      t.text     :body
      t.boolean  :admin
      t.integer  :parent_id
      t.string   :navlabel
      t.integer  :position
      t.boolean  :redirect
      t.string   :action_name
      t.string   :controller_name

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
