class CreateLoans < ActiveRecord::Migration
  def self.up
    create_table :loans do |t|
      t.integer :staff_id
      t.integer :ltype
      t.string :accno
      t.date :startdt
      t.integer :durationmn
      t.decimal :deductions

      t.timestamps
    end
  end

  def self.down
    drop_table :loans
  end
end
