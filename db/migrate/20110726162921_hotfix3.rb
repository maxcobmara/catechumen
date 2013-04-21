class Hotfix3 < ActiveRecord::Migration
  def self.up
    remove_column :assets,  :subcategory_id
    add_column    :assets,  :subcategory,   :string
    add_column    :assets,  :quantity,      :integer
    add_column    :assets,  :quantity_type, :string
    add_column    :assets,  :engine_type_id,:integer
    add_column    :assets,  :engine_no,     :string
    add_column    :assets,  :registration,  :string
    remove_column :assets,  :dept_id
    add_column    :assets,  :nationcode,    :string
  end

  def self.down
    remove_column :assets,  :subcategory
    add_column    :assets,  :subcategory_id, :integer
    remove_column    :assets,  :quantity,      :integer
    remove_column    :assets,  :quantity_type, :string
    remove_column    :assets,  :engine_type_id,:integer
    remove_column    :assets,  :engine_no,     :string
    remove_column    :assets,  :registration,  :string
    add_column        :assets,  :dept_id
    remove_column    :assets,  :nationcode,    :string

  end
end
