class CreateLibrarytransactionsearches < ActiveRecord::Migration
  def self.up
    create_table :librarytransactionsearches do |t|
      t.integer :accumbookloan
      t.integer :programme
      t.integer :fines
      t.integer :bookloans
      t.timestamps
    end
  end

  def self.down
    drop_table :librarytransactionsearches
  end
end
