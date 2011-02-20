class CreateStaffs < ActiveRecord::Migration
  def self.up
    create_table :staffs do |t|
      
      #Personal Details
      t.string  :icno
      t.string  :name
      t.integer :titlecd_id
      t.string  :code
      t.string  :fileno
      t.integer :position_id
      t.string  :coemail
      t.date    :cobirthdt
      t.string  :bloodtype
      t.string  :cooftelno
      t.string  :cooftelext
      t.string  :addr
      t.integer :poskod_id
      t.integer :mrtlstatuscd
      t.integer :statecd
      t.integer :country_cd
      t.integer :race
      t.integer :religion
      t.integer :gender
      t.string  :phonecell
      t.boolean :phonehome
      
      #Items for attaching photo
      t.string   :photo_file_name
      t.string   :photo_content_type
      t.integer  :photo_file_size
      t.datetime :photo_updated_at
  
      #Employment Details
      t.string  :employscheme
      t.string  :grade
      t.integer :employstatus
      t.string  :appointstatus
      t.date    :appointdt
      t.date    :schemedt
      t.date    :confirmdt
      t.date    :posconfirmdate
      t.string  :appointby
      t.string  :svchead
      t.string  :svctype
      t.string  :pensionstat
      t.date    :pensiondt
      t.string  :uniformstat
      t.integer :staffgrade_id
      
      #Finance
      t.string :kwspcode
      t.string :taxcode
      t.string :bank
      t.string :bankaccno
      t.string :bankacctype

      t.timestamps
    end
  end

  def self.down
    drop_table :staffs
  end
end
