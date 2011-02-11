class CreateAssetlosses < ActiveRecord::Migration
  def self.up
    create_table :assetlosses do |t|
      t.string :losstype  #dropdown: cash, asset, supplies
      t.decimal :estvalue
      t.integer :asset_id  #fetch from asset
      t.integer :part_id   #fetch from office supplies(part)
      t.integer :losslocation_id  #fetch from residence
      t.datetime :lossdt   #textarea
      t.string :losshow
      t.integer :lossstafflast_id  #fetch from staff
      t.boolean :laststaffcase
      t.boolean :laststaffstop
      t.boolean :poreport
      t.string :porepno
      t.string :poaction
      t.string :ponoreportwhy
      t.string :preventpast   #textarea
      t.string :preventfuture  #textarea
      t.string :remarks   #textarea
      t.integer :hod_id   #fetch from staff
      t.date :hodendorsedt
      t.string :moneytype
      t.boolean :new
      t.string :reportcode
      t.integer :so_id
      t.boolean :sostop
      t.date :sostopdt
      t.string :soaction
      t.boolean :ownerstop
      t.date :ownerstopdt
      t.string :owneraction
      t.boolean :supstop
      t.date :supstopdt
      t.string :supaction
      t.boolean :rulesbroken
      t.string :newrule
      t.integer :newrule_id
      t.string :nrrecommend
      t.boolean :surcharge
      t.decimal :scvalue
      t.string :screason
      t.integer :sio_id
      t.integer :ssecurity_id
      t.date :closedt

      t.timestamps
    end
  end

  def self.down
    drop_table :assetlosses
  end
end
