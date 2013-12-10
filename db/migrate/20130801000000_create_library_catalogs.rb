class CreateLibraryCatalogs < ActiveRecord::Migration
  def self.up           
    create_table :books do |t|
      t.string   :tagno
      t.string   :controlno
      t.string   :isbn
      t.string   :bookcode
      t.string   :accessionno
      t.string   :catsource
      t.string   :classlcc
      t.string   :classddc
      t.string   :title
      t.string   :author
      t.string   :publisher
      t.string   :description
      t.integer  :loantype
      t.integer  :mediatype
      t.integer  :status
      t.string   :series
      t.string   :location
      t.string   :topic
      t.string   :orderno
      t.decimal  :purchaseprice
      t.date     :purchasedate
      t.date     :receiveddate
      t.integer  :receiver_id
      t.integer  :supplier_id
      t.string   :issn
      t.string   :edition
      t.string   :photo_file_name
      t.string   :photo_content_type
      t.integer  :photo_file_size
      t.datetime :photo_updated_at
      t.string   :publish_date
      t.string   :publish_location
      t.string   :language
      t.text     :links
      t.text     :subject
      t.integer  :quantity
      t.string   :roman
      t.string   :size
      t.string   :pages
      t.string   :bibliography
      t.string   :indice
      t.string   :notes
      t.string   :backuproman
      t.timestamps
    end
    
    create_table :accessions do |t|
      t.integer  :book_id
      t.string   :accession_no
      t.string   :order_no
      t.decimal  :purchase_price
      t.date     :received
      t.integer  :received_by
      t.integer  :supplied_by
      t.timestamps
    end
    
    create_table :booksearches do |t|
      t.string   :title
      t.string   :author
      t.string   :isbn
      t.string   :accessionno
      t.string   :classno
      t.string   :accessionno_start
      t.string   :accessionno_end
      t.integer  :stock_summary
      t.integer  :accumbookloan
      t.timestamps
    end
  end
  
  def self.down
  end
end