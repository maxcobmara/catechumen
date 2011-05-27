class AddColumnsToBook < ActiveRecord::Migration
  def self.up
    add_column  :books, :publish_date,      :date
    add_column  :books, :publish_location,  :string
    add_column  :books, :language,          :string
    add_column  :books, :links,             :text
    add_column  :books, :subject,           :text
    add_column  :books, :quantity,          :integer
  end


  def self.down
  end
end
