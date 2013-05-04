class Addsupplier < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :addsupp, :class_name => 'Addbook', :foreign_key => 'addressbook_id'
  belongs_to :receivedby,      :class_name => 'Staff',   :foreign_key => 'received_by'
  
  def received_by_staff
      suid = received_by.to_a
      exists = Staff.find(:all, :select => "id").map(&:id)
      checker = suid & exists

      if received_by == nil
        ""
      elsif checker == []
        "Staff No Longer Exists"
      else
        receivedby.staff_name_with_title
      end
    end
end
