class Librarytransaction < ActiveRecord::Base
  
  before_save :varmyass
  
  belongs_to :accession, :foreign_key => 'book_id'
  belongs_to :staff
  belongs_to :student
  
  
  
  
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
