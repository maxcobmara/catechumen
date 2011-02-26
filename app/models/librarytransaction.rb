class Librarytransaction < ActiveRecord::Base
  belongs_to :book, :foreign_key => 'book_id'
  belongs_to :staff
  belongs_to :student
  
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
