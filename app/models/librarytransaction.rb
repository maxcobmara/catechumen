class Librarytransaction < ActiveRecord::Base
  
  before_save :varmyass
  
  belongs_to :accession
  belongs_to :staff
  belongs_to :student
  
  
  validates_presence_of :accession_id
  
  
  validate :staff_or_student_borrower

  def staff_or_student_borrower
    if %w(staff_id student_id).all?{|attr| self[attr].blank?}
      errors.add_to_base("A borrower is required")
    end
  end

  
  
  named_scope :all,       :conditions => [ "id IS NOT ?", nil ]
  named_scope :borrowed,  :conditions => [ "returned = ? OR returned IS ?", false, nil ]
  named_scope :returned,  :conditions => ["returned = ? AND returneddate > ?", true, 8.days.ago]
  named_scope :overdue,   :conditions => ["returnduedate < ? AND returned = ?", 1.day.ago, false]
  #named_scope :overdue, lambda { |time| { :conditions => ["returnduedate < ? AND returneddate !=?", Time.now, nil] } }
  
  FILTERS = [
    {:scope => "all",        :label => "All Transactions"},
    {:scope => "borrowed",   :label => "Out"},
    {:scope => "returned",   :label => "Returned"},
    {:scope => "overdue",    :label => "Overdue"}
  ]
  
  
  def books_that_are_out
    Librarytransaction.find(:all, :select => 'accession_id', :conditions => ["returned = ? OR returned IS ?", false, nil ]).map(&:accession_id)
  end
  
  
  
  
  def varmyass
    if extended == true && (returnduedate - checkoutdate).to_i < 15
      self.returnduedate = returnduedate + 14.days
    end
    
    if returned == false
      self.returneddate = nil
    end
    
    if finepay == false
      self.finepaydate = nil
    end
  end
  
  def extoond
    if extended == true
      '(Extended)'
    #elsif extended == nil
      #'never'
    #else
    end
      
  end
  
  def recommended_fine_value
    (returnduedate - Date.today).to_i * -1
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
  
  
  
  def borrower_name
   stid = staff_id.to_a
   suid = student_id.to_a
   stexists = Staff.find(:all, :select => "id").map(&:id)
   stuexists = Student.find(:all, :select => "id").map(&:id)
   staffchecker = stid & stexists
   studentchecker = suid & stuexists
   
      if student_id == nil && staff_id == nil
           "" 
      elsif staff_id == nil && stexists == []
           "Student No Longer Exists" 
      elsif student_id == nil && stuexists == []
           "Staff No Longer Exists" 
      elsif staff_id == nil
           " #{student.name}"   
      else
        staff.name
      end 
  end
  
  
  
   def book_details 
          suid = book_id.to_a
          exists = Book.find(:all, :select => "id").map(&:id)
          checker = suid & exists     

          if book_id == nil
             "" 
           elsif checker == []
             "Book No Longer Exists" 
          else
            book.isbn
          end
    end
    
    
  def top_ten
    dash_student = Librarytransaction.find(:all, :select => 'student_id', :conditions => ["student_id IS NOT ?", nil ]).map(&:student_id)
    b = dash_student.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
    
  end

  

  
end
