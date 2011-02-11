class CreateSdiciplines < ActiveRecord::Migration
  def self.up
    create_table :sdiciplines do |t|
      t.integer :reportedby_id
      t.integer :student_id
      t.text :details
      t.date :reporteddt
      t.integer :cofile_id
      t.date :casedt
      t.string :referredby
      t.text :investigation
      t.string :status
      t.text :action
      t.date :closedtcollege
      t.string :location
      t.text :otherinfo
      t.date :bplsenddt
      t.date :jtkpdt
      t.text :jtkpdecision
      t.date :jtkpdescisionrxdt
      t.date :appealdt
      t.text :appealdecision
      t.date :appealdecisionrxdt
      t.integer :supplier_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sdiciplines
  end
end
