class Librarytransaction < ActiveRecord::Base
  
  before_save :varmyass
  
  belongs_to :accession, :foreign_key => 'book_id'
  belongs_to :book
  belongs_to :staff
  belongs_to :student
  
  validates_presence_of     :checkoutdate, :book_id
  
  def bil
     v=1
  end
  
  def borrower_filter
     if ru_staff == TRUE
       "STAF PLAMM"
    else
      "PELATIH"
    end
  end
  
  def recommended_fine_value
      (returnduedate - Date.today).to_i * -1
    end
  
  def varmyass
    if extended == true
      self.returnduedate = returnduedate + 14.days
      self.extended = false
    end
  end
  
  def extoond
    if extended == false
      '(Extended)'
    elsif extended == nil
      'never'
    else
    end
      
  end
  
  def loaner
    if student_id == nil && staff_id == nil
      ""
    elsif ru_staff == true
      staff.staff_name_with_position
    elsif student_id != nil
      student.name
   else
     ""
    end 
  end
  
  def overdue_book
    Date.today - returnduedate
  end
  
  
  def overdue_fine
    if returneddate == nil && finepay == FALSE
      (Date.today - returnduedate) * 0.20
    else
      "Fine Paid"
  end
end
    
def staff_details
   suid = staff_id.to_a
   exists = Staff.find(:all, :select => "id").map(&:id)
   checker = suid & exists
   
   if staff_id == nil
     ""
   elsif checker == []
     "Staff No Longer Exists"
   else
     staff.staff_name_with_title
   end
 end   
 
 def student_details
    suid = student_id.to_a
    exists = Student.find(:all, :select => "id").map(&:id)
    checker = suid & exists

    if student_id == nil
      ""
    elsif checker == []
      "Student No Longer Exists"
    else
      student.name
    end
  end 
  
  def isbn_details
     suid = book_id.to_a
     exists = Accession.find(:all, :select => "id").map(&:id)
     checker = suid & exists

     if book_id == nil
       ""
     elsif checker == []
       "-"
     else
       accession.book.isbn
     end
   end
   
   def title_details
       suid = book_id.to_a
       exists = Accession.find(:all, :select => "id").map(&:id)
       checker = suid & exists

       if book_id == nil
         ""
       elsif checker == []
         "-"
       else
         accession.accession_book
       end
     end
    
    
      
    
    

  
  named_scope :all,         :conditions => [ "id IS NOT ?", nil ]
  named_scope :borrowed,    :conditions => { :returned => false }
  named_scope :returned,    :conditions => { :returned => true }
  named_scope :overdue, lambda { |time| { :conditions => ["returnduedate < ?", Time.now] } }
  
  FILTERS = [
    {:scope => "all",        :label => "All Transactions"},
    {:scope => "borrowed",   :label => "Borrowed"},
    {:scope => "returned",    :label => "Returned"},
    {:scope => "overdue",    :label => "Overdue"}
  ]
  
end
