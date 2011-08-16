class AddFieldsToDocuments < ActiveRecord::Migration
  def self.up
    add_column :documents, :otherinfo, :text
    add_column :documents, :cctype_id, :integer
    add_column :documents, :cc1staff_id, :integer
    add_column :documents, :cc1date, :date
    add_column :documents, :cc1action, :string
    add_column :documents, :cc1remarks, :text
    add_column :documents, :cc1closed, :boolean
    add_column :documents, :cc2staff_id, :integer
    add_column :documents, :cc2date, :date
    add_column :documents, :cc2action, :string
    add_column :documents, :cc2remarks, :text
    add_column :documents, :cc2closed, :boolean
  end

  def self.down
    remove_column :documents, :cc2closed
    remove_column :documents, :cc2remarks
    remove_column :documents, :cc2action
    remove_column :documents, :cc2date
    remove_column :documents, :cc2staff_id
    remove_column :documents, :cc1closed
    remove_column :documents, :cc1remarks
    remove_column :documents, :cc1action
    remove_column :documents, :cc1date
    remove_column :documents, :cc1staff_id
    remove_column :documents, :cctype_id
    remove_column :documents, :otherinfo
  end
end
