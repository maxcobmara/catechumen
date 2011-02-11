class ChangePositioncodeToInteger < ActiveRecord::Migration
  def self.up
    def self.up
        add_column :positions, :convert_parent_id, :integer

        # look up the schema's to be able to re-inspect the Project model
        # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
        Project.reset_column_information

        # loop over the collection
        Position.all.each do |p|
            p.convert_parent_id = p.parent_id
            p.save
        end

        # remove the older status column
        remove_column :positions, :parent_id
        # rename the convert_status to status column
        rename_column :positions,:convert_parent_id,:parent_id
      end
  end

  def self.down
    change_column :positions, :parent_id, :string
  end
end
