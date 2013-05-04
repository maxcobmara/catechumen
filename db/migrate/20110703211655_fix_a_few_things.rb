class FixAFewThings < ActiveRecord::Migration
  def self.up
    add_column :staffs,   :transportclass_id,     :string
    add_column :addbooks, :shortname,             :string
    add_column :assets,   :country_id,            :integer
    add_column :assets,   :warranty_length,       :integer
    add_column :assets,   :warranty_length_type,  :integer
    add_column :assets,   :category_id,           :integer
    add_column :assets,   :subcategory_id,        :integer
    add_column :staffs,   :country_id,            :integer

    add_column :travelclaimrequests,   :mileage,  :decimal

    rename_column :assets, :type,       :typename
    rename_column :assets, :model,      :modelname
  end

  def self.down
    remove_column :staffs,   :transportclass_id
    remove_column :addbooks, :shortname   
    remove_column :assets,   :country_id
    remove_column :assets,   :warranty_length
    remove_column :assets,   :warranty_length_type
    remove_column :assets,   :category_id
    remove_column :assets,   :subcategory_id
    remove_column :staffs,   :country_id

    remove_column :travelclaimrequests,   :mileage

    rename_column :assets,  :typename,    :type
    rename_column :assets,  :modelname,   :model
  end
end
