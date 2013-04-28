class StudentCounselingSession < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_save :set_to_nil_where_false
  
  belongs_to :student
  belongs_to :student_discipline_case, :foreign_key => 'case_id'
  #belongs_to :created_by, :polymorphic => true,  :foreign_key => 'created_by'
  
  validates_presence_of :student_id
  
  attr_accessor :feedback,:feedback_this, :feedback_final
  
  #before logic
  def set_to_nil_where_false
    if is_confirmed == false
      self.confirmed_at	= nil
    end
  end
  
  
  
  def self.find_appointment(search)
    if search
      find(:all, :include => :student, :conditions => ['requested_at > ? AND students.name ILIKE ?', Time.now, "%#{search}%" ], :order => 'requested_at DESC')
    else
      find(:all, :include => :student, :conditions => ['requested_at > ?', Time.now - 2.hours ], :order => 'requested_at DESC')
    end
  end
  
  def self.find_session_done(search)
    if search
      find(:all, :include => :student, :conditions => ['confirmed_at < ? AND students.name ILIKE ?', Time.now, "%#{search}%" ], :order => 'confirmed_at DESC')
    else
      find(:all, :include => :student, :conditions => ['confirmed_at < ?', Time.now ], :order => 'confirmed_at DESC')
    end
  end
  

  
end
