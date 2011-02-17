class CreateAssettracks < ActiveRecord::Migration
  def self.up
    create_table :assettracks do |t|
      t.integer :asset_id
      t.integer :staff_id
      t.date    :reservationdate
      t.date    :use_startdate
      t.date    :use_enddate
      t.integer :issuedby
      t.date    :issuedate
      t.date    :expectedreturndate
      t.integer :returnedto
      t.date    :actualreturndate
      t.string  :remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :assettracks
  end
end
