class Fixaddcolumn < ActiveRecord::Migration
  def self.up
    # traveldetail
    add_column :traveldetails, :travelrequest_id, :integer
    add_column :traveldetails, :location_from, :string
    add_column :traveldetails, :location_to, :string
    
    #travelrequest
    add_column :travelrequests, :reason_1, :boolean
    add_column :travelrequests, :reason_2, :boolean
    add_column :travelrequests, :reason_3, :boolean
    add_column :travelrequests, :reason_4, :boolean
    add_column :travelrequests, :reason_5, :boolean
    add_column :travelrequests, :reason_6, :boolean
    add_column :travelrequests, :reason_7, :boolean   
    add_column :travelrequests, :reason_8, :boolean 
    add_column :travelrequests, :remark_approver, :string
  end

  def self.down
  end
end
