class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.integer :subject_id
      t.string :topic_code
      t.integer :sequenceno
      t.string :name
      t.time :duration
      t.string :version
      t.string :objective
      t.text :content
      t.text :activity
      t.integer :creator_id
      t.boolean :approved
      t.integer :approvedby_id
      t.date :approved_date
      t.string :remarks
      t.string :checkcode
      t.date :checkdate

      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
