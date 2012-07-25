class Librarytransaction < ActiveRecord::Base
  
  before_save :varmyass
  
  belongs_to :accession, :foreign_key => 'book_id'
  belongs_to :staff
  belongs_to :student
  
  
  validates_presence_of :book_id
  
  validate :at_least_one_name

  def at_least_one_name
    self.staff_id  && self.student_id
    errors.add(:staff_id, "Please Select Borrower")
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

  
  named_scope :all,         :conditions => [ "id IS NOT ?", nil ]
  named_scope :borrowed,    :conditions => { :returned => false }
  named_scope :returned,    :conditions => { :returned => true }
  named_scope :overdue, lambda { |time| { :conditions => ["returnduedate < ? AND returneddate !=?", Time.now, nil] } }
  
  FILTERS = [
    {:scope => "all",        :label => "All Transactions"},
    {:scope => "borrowed",   :label => "Borrowed"},
    {:scope => "returned",    :label => "Returned"},
    {:scope => "overdue",    :label => "Overdue"}
  ]
  
end
