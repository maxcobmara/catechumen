class CreateLibrarytransactions < ActiveRecord::Migration
  def self.up
    create_table :librarytransactions do |t|
      t.integer :book_id
      t.boolean :ru_staff
      t.integer :staff_id
      t.integer :student_id
      t.date    :checkoutdate
      t.date    :returnduedate
      t.boolean :extended
      t.boolean :returned
      t.date    :returneddate
      t.decimal :fine
      t.boolean :finepay
      t.date    :finepaydate
      t.boolean :reportlost
      t.text    :report
      t.date    :reportlostdate
      t.date    :replaceddate

      t.timestamps
    end
  end

  def self.down
    drop_table :librarytransactions
  end
end
