class CreateDocuments < ActiveRecord::Migration
  def self.up   
    create_table :cofiles do |t|
      t.string   :cofileno
      t.string   :name
      t.string   :location
      t.integer  :owner_id
      t.boolean  :onloan
      t.integer  :staffloan_id
      t.date     :onloandt
      t.date     :onloanxdt
      t.timestamps
    end
    
    create_table :documents do |t|
      t.string   :serialno
      t.string   :refno
      t.integer  :category
      t.string   :title
      t.date     :letterdt
      t.date     :letterxdt
      t.string   :from
      t.integer  :stafffiled_id
      t.integer  :file_id
      t.boolean  :closed
      t.string   :data_file_name
      t.string   :data_content_type
      t.integer  :data_file_size
      t.datetime :data_updated_at
      t.text     :otherinfo
      t.integer  :cctype_id
      t.integer  :cc1staff_id
      t.date     :cc1date
      t.string   :cc1action
      t.text     :cc1remarks
      t.boolean  :cc1closed
      t.integer  :cc2staff_id
      t.date     :cc2date
      t.string   :cc2action
      t.text     :cc2remarks
      t.boolean  :cc2closed
      t.date     :cc1actiondate
      t.string   :dataaction_file_name
      t.string   :dataaction_content_type
      t.integer  :dataaction_file_size
      t.datetime :dataaction_updated_at
      t.integer  :prepared_by
      t.string   :sender
      t.timestamps
    end

    create_table :documents_staffs, :id => false do |t|
      t.integer :document_id
      t.integer :staff_id
    end

    create_table :documentsearches, :force => true do |t|
      t.string   :refno
      t.integer  :category
      t.string   :title
      t.date     :letterdt
      t.date     :letterxdt
      t.string   :from
      t.integer  :file_id
      t.boolean  :closed
      t.string   :sender
      t.date     :letterdtend
      t.date     :letterxdtend
      t.timestamps
    end
  end
  
  def self.down
  end
end

 