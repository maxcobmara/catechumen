class Librarytransaction < ActiveRecord::Base
  
  before_save :varmyass
  
  belongs_to :accession
  belongs_to :staff
  belongs_to :student
  belongs_to :libcheckoutby, :class_name => 'Staff', :foreign_key => 'libcheckout_by'
  belongs_to :libextendby, :class_name => 'Staff', :foreign_key => 'libextended_by'
  belongs_to :libreturnby, :class_name => 'Staff', :foreign_key => 'libreturned_by'
  
  attr_accessor :booktitle, :staf_who, :student_who, :accessionbook
  
  validates_presence_of :accession_id
  validate :staff_or_student_borrower
  
  #18May2013-compulsory to have this method in order for autocomplete field to work
  def staff_who
  end
  def student_who
  end
  def accessionbook 
  end
  
  #this part works for 1 item only
  def self.get_accession_id(accession_no_title) 
    accession_no = accession_no_title.split(" ")[0]
    return Accession.find_by_accession_no(accession_no).id unless accession_no_title.blank?
  end
  
  def staff_or_student_borrower
    if %w(staff_id student_id).all?{|attr| self[attr].blank?}
      errors.add_to_base("A borrower is required")
    end
  end

 # def fine_must_paid_if_overdue
    #if Date.today > returnduedate && finepay.nil?
     #errors.add_to_base("Fine must be paid if overdue")
    #end 
  #end
  
  #named_scope :all,       :conditions => [ "id IS NOT ?", nil ]
  named_scope :borrowed,  :conditions => [ "returned = ? OR returned IS ?", false, nil ]
  #named_scope :returned,  :conditions => ["returned = ? AND returneddate > ?", true, 8.days.ago]
  named_scope :overdue,   :conditions => ["returnduedate < ? AND returneddate IS NULL", 1.day.ago ]
  #named_scope :overdue, lambda { |time| { :conditions => ["returnduedate < ? AND returneddate !=?", Time.now, nil] } }
  
  #as per requested by user -> index : 'active transaction' : only active transaction.
  FILTERS = [
    #{:scope => "all",        :label => "Semua transaksi"},   #All 
    {:scope => "borrowed",   :label => "Sedang dipinjam"},    #Borrowed
    #{:scope => "returned",   :label => "Telah dipulangkan"},  #Returned
    {:scope => "overdue",    :label => "Tamat Tempoh"}        #Overdue
  ]
  #All Transactions, Out, Returned, Overdue
  
  def books_that_are_out
    Librarytransaction.find(:all, :select => 'accession_id', :conditions => ["returned = ? OR returned IS ?", false, nil ]).map(&:accession_id)
  end
  
  def varmyass
    if extended == true && (returnduedate - checkoutdate).to_i < 15
      self.returnduedate = returnduedate + 14.days
      self.libextended_by = Login.current_login.staff_id
    end
    
    if returned == false
      self.returneddate = nil
    elsif returned == true
      self.returneddate = Date.today
      self.libreturned_by = Login.current_login.staff_id
    end
    
    if finepay == false
      self.finepaydate = nil
    elsif finepay == true
      self.finepaydate = Date.today
      if fine == nil
        self.fine = self.recommended_fine_value
      end 
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
    (returnduedate - Date.today).to_i * -0.2
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
   stid = Array(staff_id)
   suid = Array(student_id)
   stexists = Staff.find(:all, :select => "id").map(&:id)
   stuexists = Student.find(:all, :select => "id").map(&:id)
   staffchecker = stid & stexists
   studentchecker = suid & stuexists
   
      if student_id == 0 && staff_id == 0 #student_id == nil && staff_id == nil 
           "" 
      elsif staff_id == 0 && stexists == [] #staff_id == nil && stexists == []
           "Student No Longer Exists" 
      elsif student_id == 0 && stuexists == []  #student_id == nil && stuexists == []
          "Staff No Longer Exists" 
      elsif student_id == 0
          staff.name
      elsif staff_id == 0
          student.name
      end
  end
  
  def book_details 
    check_kin {book.isbn}
  end
     
  def top_ten
    dash_student = Librarytransaction.find(:all, :select => 'student_id', :conditions => ["student_id IS NOT ?", nil ]).map(&:student_id)
    b = dash_student.inject(Hash.new(0)) {|h,i| h[i] += 1; h } 
  end
  
end
