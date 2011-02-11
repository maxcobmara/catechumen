class AddSubPages < ActiveRecord::Migration
  def self.up
       add_column :pages, :parent_id, :integer
       add_column :pages, :navlabel, :string
       add_column :pages, :position, :integer
  end

  def self.down
        remove_column :pages, :parent_id   #<-- when you do a remove coloumn you do not need the type e.g :integer
        remove_column :pages, :navlabel
        remove_column :pages, :position
  end
end
