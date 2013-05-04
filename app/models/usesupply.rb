class Usesupply < ActiveRecord::Base
 belongs_to :supplier
 belongs_to :issuesupply,       :class_name => 'Staff', :foreign_key => 'issuedby'
 belongs_to :receivesupply,       :class_name => 'Staff', :foreign_key => 'receivedby'

 belongs_to :stockdetail, :foreign_key => 'stock_detail'
 
 def issuestaff_details # 14/11/2011 - Shaliza added code for issuestaff and received staff no longer exists in show page-->
   suid = issuedby.to_a
   exists = Staff.find(:all, :select => "id").map(&:id)
   checker = suid & exists
   
   if issuedby == nil
     ""
   elsif checker == []
     "Staff No Longer Exists"
   else
     issuesupply.staff_name_with_title
   end
 end
 
 def receivedby_details
    suid = receivedby.to_a
    exists = Staff.find(:all, :select => "id").map(&:id)
    checker = suid & exists

    if receivedby == nil
      ""
    elsif checker == []
      "Staff No Longer Exists"
    else
      receivesupply.staff_name_with_title
    end
  end
  
  def refno_details
     suid = stock_detail.to_a
     exists = Stockdetail.find(:all, :select => "id").map(&:id)
     checker = suid & exists

     if stock_detail == nil
       ""
     elsif checker == []
       "-"
     else
       stockdetail.ref_no
     end
   end
end