class HotfixForKskb < ActiveRecord::Migration
    def self.up
      add_column    :staffs,  :birthcertno,     :string
      change_column :assets,  :dept_id,         :string
      add_column    :kins,    :mykadno,         :string
      add_column    :books,   :roman,           :string
      add_column    :books,   :size,            :string
      add_column    :books,   :pages,           :string
      add_column    :books,   :bibliography,    :string
      add_column    :books,   :indice,          :string
      add_column    :books,   :notes,           :string
      change_column :books,   :publish_date,    :string
      remove_column :assets,  :category
    end

    def self.down
      remove_column :staffs,  :birthcertno
      change_column :assets,  :dept_id,   :integer
      remove_column :kins,    :mykadno
      add_column    :books,   :roman
      add_column    :books,   :size         
      add_column    :books,   :pages         
      add_column    :books,   :bibliography    
      add_column    :books,   :indice         
      add_column    :books,   :notes          
      change_column :books,   :publish_date,    :date
    end
end
